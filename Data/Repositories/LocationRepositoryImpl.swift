//
//  LocationRepositoryImpl.swift
//  Data
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import Data_Network
import Data_Realm
import RxSwift

struct LocationRepositoryImpl: Domain.LocationRepository {

    private let networkProvider: NetworkProvider
    private let dataBaseProvider: DataBaseProvider
    
    init(networkProvider: NetworkProvider, dataBaseProvider: DataBaseProvider) {
        self.networkProvider = networkProvider
        self.dataBaseProvider = dataBaseProvider
    }
    
    func getLocationDetail(id: String, position: Position) -> Observable<Location> {
        let predicate = NSPredicate(format: "locationId == %@", id)
        let favoriteLocation = dataBaseProvider.query(type: LocationDB.self,
                                                      withPredicate: predicate,
                                                      sortDescriptors: [])
            .map { !$0.isEmpty }

        let positionDto = PositionDto(latitude: position.latitude,
                                      longitude: position.longitude)
        let request = LocationDetailRequest(locationId: id,
                                            prox: (positionDto, nil))

        return networkProvider.getLocationDetail(request: request)
            .asObservable()
            .flatMap({ response -> Observable<Location> in
                return favoriteLocation
                    .map { isFavorite in
                        return try self.mapLocation(response, isFavorite: isFavorite)
                }
            })
    }
    
    func saveLocation(location: Location) -> Completable {
        let locationDb = mapLocationDB(location)
        return dataBaseProvider.save(entity: locationDb)
    }
    
    func deleteLocation(location: Location) -> Completable {
        let predicate = NSPredicate(format: "locationId == %@", location.locationId)
        return dataBaseProvider.query(type: LocationDB.self,
                                      withPredicate: predicate,
                                      sortDescriptors: [])
            .filter { !$0.isEmpty }
            .first()
            .flatMapCompletable({ locationDB -> Completable in
                return self.dataBaseProvider.delete(entity: locationDB!.first!)
            })
    }

    func getFavorites() -> Observable<[Location]> {
        return dataBaseProvider.queryAll(LocationDB.self)
            .map(mapLocations)
    }
}

// MAPPING
extension LocationRepositoryImpl {
    func mapLocation(_ dto: LocationDetailResponse, isFavorite: Bool) throws -> Location {
        guard let result = dto.response.view.first?.result.first else { throw CtwError.message("Location not found") }
        return Location(locationId: result.location.locationId,
                        label: result.location.address.label,
                        street: result.location.address.street,
                        postalCode: result.location.address.postalCode,
                        coordinates: mapPosition(result.location.displayPosition),
                        distance: result.distance ?? 0,
                        isFavorite: isFavorite)
    }

    func mapPosition(_ dto: PositionDto) -> Position {
        return Position(latitude: dto.latitude, longitude: dto.longitude)
    }

    func mapLocationDB(_ domain: Location) -> LocationDB {
        return LocationDB(locationId: domain.locationId,
                          label: domain.label,
                          street: domain.street,
                          postalCode: domain.postalCode,
                          latitude: domain.coordinates.latitude,
                          longitude: domain.coordinates.longitude,
                          distance: domain.distance)
    }

    func mapLocations(_ dbs: [LocationDB]) -> [Location] {
        return dbs.map(mapLocation)
    }

    func mapLocation(_ db: LocationDB) -> Location {
        let coordinates = Position(latitude: db.latitude,
                                   longitude: db.longitude)
        return Location(locationId: db.locationId,
                        label: db.label,
                        street: db.street,
                        postalCode: db.postalCode,
                        coordinates: coordinates,
                        distance: db.distance,
                        isFavorite: true)
    }
}

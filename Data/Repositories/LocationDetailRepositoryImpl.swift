//
//  LocationDetailRepositoryImpl.swift
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

struct LocationDetailRepositoryImpl: Domain.LocationDetailRepository {
    
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func getLocationDetail(id: String, position: Position) -> Single<AddressDetail> {
        let positionDto = PositionDto(latitude: position.latitude,
                                      longitude: position.longitude)
        let request = LocationDetailRequest(locationId: id,
                                            prox: (positionDto, nil))
        return networkProvider.getLocationDetail(request: request)
            .map(mapAddressDetail)
    }
    
    func saveLocation(location: String) -> Completable {
        return Completable.empty()
    }
    
    func deleteLocation(location: String) -> Completable {
        return Completable.empty()
    }
}

// MAPPING
extension LocationDetailRepositoryImpl {
    func mapAddressDetail(_ dto: LocationDetailResponse) throws -> AddressDetail {
        guard let result = dto.response.view.first?.result.first else { throw CtwError.message("Location not found") }
        return AddressDetail(locationId: result.location.locationId,
                             label: result.location.address.label,
                             street: result.location.address.street,
                             postalCode: result.location.address.postalCode,
                             coordinates: mapPosition(result.location.displayPosition),
                             distance: result.distance ?? 0)
    }

    func mapPosition(_ dto: PositionDto) -> Position {
        return Position(latitude: dto.latitude, longitude: dto.longitude)
    }
}

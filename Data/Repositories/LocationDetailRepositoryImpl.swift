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
    
    func getLocationDetail(id: String, position: Position) -> Observable<String> {
        let positionDto = PositionDto(latitude: position.latitude,
                                      longitude: position.longitude)
        let request = LocationDetailRequest(locationId: id,
                                            prox: (positionDto, nil))
        return networkProvider.getLocationDetail(request: request)
            .map({ response -> String in
                print("\n**** MAPEAR Detail ****\n")
                return ""
            }).asObservable()
    }
    
    func saveLocation(location: String) -> Completable {
        return Completable.empty()
    }
    
    func deleteLocation(location: String) -> Completable {
        return Completable.empty()
    }
}

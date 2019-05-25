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

final class LocationDetailRepositoryImpl: Domain.LocationDetailRepository {

    init() {}

    func getLocationDetail(id: String) -> Observable<String> {
        return Observable.empty()
    }

    func saveLocation(location: String) -> Completable {
        return Completable.empty()
    }

    func deleteLocation(location: String) -> Completable {
        return Completable.empty()
    }
}

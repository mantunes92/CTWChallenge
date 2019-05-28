//
//  LocationDetailRepository.swift
//  Domain
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import RxSwift

public protocol LocationDetailRepository {
    func getLocationDetail(id: String, position: Position) -> Single<AddressDetail>
    func saveLocation(location: String) -> Completable
    func deleteLocation(location: String) -> Completable
}

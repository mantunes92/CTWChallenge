//
//  LocationRepository.swift
//  Domain
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import RxSwift

public protocol LocationRepository {
    func getLocations(named: String) -> Single<[Suggestion]>
}

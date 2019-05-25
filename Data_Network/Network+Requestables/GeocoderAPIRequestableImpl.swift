//
//  GeocoderAPIRequestableImpl.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import RxSwift

extension Network: GeocoderAPIRequestable {
    public func getLocationDetail(id: String) -> Single<String> {
        return Single.just("")
    }
}

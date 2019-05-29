//
//  GeocoderAPIRequestableImpl.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

extension Network: GeocoderAPIRequestable {
    public func getLocationDetail(request: LocationDetailRequest) -> Single<LocationDetailResponse> {
        return provider.rx.request(MultiTarget(GeocoderAPI.getLocationDetail(request: request)), callbackQueue: DispatchQueue.global(qos: .background))
            .filterSuccessfulStatusCodes()
            .map(LocationDetailResponse.self)
            .handleErrorIfNeeded()
    }
}

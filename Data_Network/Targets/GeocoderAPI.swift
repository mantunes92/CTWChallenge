//
//  GeocoderAPI.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public protocol GeocoderAPIRequestable {
    func getLocationDetail(request: LocationDetailRequest) -> Single<LocationDetailResponse>
}

enum GeocoderAPI {
    case getLocationDetail(request: LocationDetailRequest)
}

// MARK: - TargetType Protocol Implementation
extension GeocoderAPI: TargetType {
    var baseURL: URL {
        return URL(string: Configuration.geocoderBasePath)!
    }

    var path: String {
        switch self {
        case .getLocationDetail:
            return Configuration.geocoderGeocodingPath
        }
    }

    var method: Moya.Method {
        switch self {
        case .getLocationDetail:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getLocationDetail(let request):
            return .requestParameters(parameters: request.queryDict,
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}

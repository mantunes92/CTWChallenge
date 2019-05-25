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
    func getLocationDetail(id: String) -> Single<String>
}

enum GeocoderAPI {
    case getLocationDetail(id: String)
}

// MARK: - TargetType Protocol Implementation
extension GeocoderAPI: TargetType {
    var baseURL: URL {
        return URL(string: Configuration.geocoderBasePath)!
    }

    var path: String {
        switch self {
        case .getLocationDetail(let id):
            return Configuration.geocoderGeocodingPath
        }
    }

    var method: Moya.Method {
        switch self {
        case .getLocationDetail(let id):
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getLocationDetail(let id):
            return .requestParameters(parameters: [:],
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}

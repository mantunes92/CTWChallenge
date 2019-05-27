//
//  GeocoderAutocompleteAPI.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public protocol GeocoderAutocompleteAPIRequestable {
    func getSuggestions(request: SuggestionsRequest) -> Single<SuggestionsResponse>
}

enum GeocoderAutocompleteAPI {
    case getSuggestions(request: SuggestionsRequest)
}

// MARK: - TargetType Protocol Implementation
extension GeocoderAutocompleteAPI: TargetType {
    var baseURL: URL {
        return URL(string: Configuration.geocoderAutocompleteBasePath)!
    }

    var path: String {
        switch self {
        case .getSuggestions:
            return Configuration.geocoderAutocompleteSuggestionsPath
        }
    }

    var method: Moya.Method {
        switch self {
        case .getSuggestions:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getSuggestions(let request):
            return .requestParameters(parameters: request.queryDict,
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}

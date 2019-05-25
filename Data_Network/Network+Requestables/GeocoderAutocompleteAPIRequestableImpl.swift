//
//  GeocoderAutocompleteAPIRequestableImpl.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

extension Network: GeocoderAutocompleteAPIRequestable {
    public func getSuggestions(request: SuggestionsRequest) -> Single<SuggestionsResponse> {
        return provider.rx.request(MultiTarget(GeocoderAutocompleteAPI.getSuggestions(request: request)), callbackQueue: DispatchQueue.global(qos: .background))
            .map(SuggestionsResponse.self)
    }
}

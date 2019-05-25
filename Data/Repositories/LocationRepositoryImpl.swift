//
//  LocationRepositoryImpl.swift
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

final class LocationRepositoryImpl: Domain.LocationRepository {

    private let networkProvider: NetworkProvider

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    func getLocations(named: String) -> Single<[Suggestion]> {
        let request = SuggestionsRequest(query: named)
        return networkProvider.getSuggestions(request: request)
            .map({ response -> [Suggestion] in
                print("Resposta chegou")
                return []
            })
    }
}

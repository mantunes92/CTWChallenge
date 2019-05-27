//
//  SuggestionsRepositoryImpl.swift
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

struct SuggestionsRepositoryImpl: Domain.SuggestionsRepository {

    private let networkProvider: NetworkProvider

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    func getLocations(named: String, position: Position) -> Single<[Suggestion]> {
        let positionDto = PositionDto(latitude: position.latitude,
                                      longitude: position.longitude)
        let request = SuggestionsRequest(query: named,
                                         prox: (positionDto, nil))
        return networkProvider.getSuggestions(request: request)
            .map({ response -> [Suggestion] in
                print("\n**** MAPEAR Suggestion ****\n")
                return []
            })
    }
}

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
        guard !named.isEmpty else { return .just([]) }
        let positionDto = PositionDto(latitude: position.latitude,
                                      longitude: position.longitude)
        let request = SuggestionsRequest(query: named,
                                         prox: (positionDto, nil))
        return networkProvider.getSuggestions(request: request)
            .map { $0.suggestions }
            .map(mapSuggestions)
            .map(orderByDistance)
    }

    private func orderByDistance(_ suggestions: [Suggestion]) -> [Suggestion] {
        return suggestions.sorted(by: { $0.distance > $1.distance })
    }

    private func mapSuggestions(_ dtos: [SuggestionDto]) -> [Suggestion] {
        return dtos.map(mapSuggestion)
    }
    private func mapSuggestion(_ dto: SuggestionDto) -> Suggestion {
        return Suggestion(label: dto.label,
                          language: dto.language,
                          countryCode: dto.countryCode,
                          locationId: dto.locationId,
                          address: mapAddress(dto.address),
                          distance: dto.distance ?? 0,
                          matchLevel: mapMatchLevel(dto.matchLevel))
    }

    private func mapAddress(_ dto: AddressDto) -> Address {
        return Address(country: dto.country,
                       state: dto.state,
                       county: dto.county,
                       city: dto.city,
                       district: dto.district,
                       street: dto.street,
                       houseNumber: dto.houseNumber,
                       unit: dto.unit,
                       postalCode: dto.postalCode)
    }

    private func mapMatchLevel(_ dto: MatchLevelDto) -> MatchLevel {
        switch dto {
        case .houseNumber:
            return .houseNumber
        case .intersection:
            return .intersection
        case .street:
            return .street
        case .postalCode:
            return .postalCode
        case .district:
            return .district
        case .city:
            return .city
        case .county:
            return .county
        case .state:
            return .state
        case .country:
            return .country
        }
    }
}

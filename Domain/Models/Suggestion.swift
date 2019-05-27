//
//  Suggestion.swift
//  Domain
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct Suggestion: Hashable {
    public let label: String
    public let language: String
    public let countryCode: String
    public let locationId: String
    public let address: Address
    public let distance: Int
    public let matchLevel: MatchLevel

    public init(label: String,
                language: String,
                countryCode: String,
                locationId: String,
                address: Address,
                distance: Int,
                matchLevel: MatchLevel) {
        self.label = label
        self.language = language
        self.countryCode = countryCode
        self.locationId = locationId
        self.address = address
        self.distance = distance
        self.matchLevel = matchLevel
    }
}

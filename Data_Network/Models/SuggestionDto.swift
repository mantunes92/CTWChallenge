//
//  SuggestionDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct SuggestionDto: Codable {
    public let label: String
    public let language: String
    public let countryCode: String
    public let locationId: String
    public let address: AddressDto
    public let distance: Int?
    public let matchLevel: MatchLevelDto

    enum CodingKeys: String, CodingKey {
        case label = "label"
        case language = "language"
        case countryCode = "countryCode"
        case locationId = "locationId"
        case address = "address"
        case distance = "distance"
        case matchLevel = "matchLevel"
    }

    public init(label: String,
                language: String,
                countryCode: String,
                locationId: String,
                address: AddressDto,
                distance: Int,
                matchLevel: MatchLevelDto) {
        self.label = label
        self.language = language
        self.countryCode = countryCode
        self.locationId = locationId
        self.address = address
        self.distance = distance
        self.matchLevel = matchLevel
    }
}

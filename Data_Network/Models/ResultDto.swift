//
//  ResultDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct ResultDto: Codable {
    public let relevance: Int
    public let distance: Double?
    public let matchLevel: String
    public let matchType: String?
    public let location: LocationDto

    enum CodingKeys: String, CodingKey {
        case relevance = "Relevance"
        case distance = "Distance"
        case matchLevel = "MatchLevel"
        case matchType = "MatchType"
        case location = "Location"
    }

    public init(relevance: Int,
                distance: Double?,
                matchLevel: String,
                matchType: String?,
                location: LocationDto) {
        self.relevance = relevance
        self.distance = distance
        self.matchLevel = matchLevel
        self.matchType = matchType
        self.location = location
    }
}

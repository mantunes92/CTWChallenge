//
//  Location.swift
//  Domain
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct Location: Hashable {
    public let locationId: String
    public let label: String
    public let street: String?
    public let postalCode: String?
    public let coordinates: Position
    public let distance: Double
    public let isFavorite: Bool

    public init(locationId: String,
                label: String,
                street: String?,
                postalCode: String?,
                coordinates: Position,
                distance: Double,
                isFavorite: Bool) {
        self.locationId = locationId
        self.label = label
        self.street = street
        self.postalCode = postalCode
        self.coordinates = coordinates
        self.distance = distance
        self.isFavorite = isFavorite
    }
}

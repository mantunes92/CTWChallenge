//
//  Position.swift
//  Domain
//
//  Created by Marcelo Antunes on 5/27/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct Position: Hashable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double,
                longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

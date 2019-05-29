//
//  MapViewDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct MapViewDto: Codable {
    public let topLeft: PositionDto
    public let bottomRight: PositionDto

    enum CodingKeys: String, CodingKey {
        case topLeft = "TopLeft"
        case bottomRight = "BottomRight"
    }

    public init(topLeft: PositionDto, bottomRight: PositionDto) {
        self.topLeft = topLeft
        self.bottomRight = bottomRight
    }
}

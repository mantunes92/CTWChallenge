//
//  MetaInfoDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct MetaInfoDto: Codable {
    public let timestamp: String

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
    }

    public init(timestamp: String) {
        self.timestamp = timestamp
    }
}

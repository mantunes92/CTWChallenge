//
//  AdditionalDataDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct AdditionalDataDto: Codable {
    public let value: String
    public let key: String

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case key = "key"
    }

    public init(value: String, key: String) {
        self.value = value
        self.key = key
    }
}

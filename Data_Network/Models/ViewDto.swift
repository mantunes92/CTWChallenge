//
//  ViewDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct ViewDto: Codable {
    public let type: String
    public let viewId: Int
    public let result: [ResultDto]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case viewId = "ViewId"
        case result = "Result"
    }

    public init(type: String, viewId: Int, result: [ResultDto]) {
        self.type = type
        self.viewId = viewId
        self.result = result
    }
}

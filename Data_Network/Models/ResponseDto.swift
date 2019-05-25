//
//  ResponseDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct ResponseDto: Codable {
    public let metaInfo: MetaInfoDto
    public let view: [ViewDto]

    enum CodingKeys: String, CodingKey {
        case metaInfo = "MetaInfo"
        case view = "View"
    }

    public init(metaInfo: MetaInfoDto, view: [ViewDto]) {
        self.metaInfo = metaInfo
        self.view = view
    }
}

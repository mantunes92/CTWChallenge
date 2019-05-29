//
//  LocationDetailResponse.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct LocationDetailResponse: Codable {
    public let response: ResponseDto

    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }

    public init(response: ResponseDto) {
        self.response = response
    }
}

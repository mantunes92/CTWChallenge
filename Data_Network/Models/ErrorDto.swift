//
//  ErrorDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/26/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct ErrorDto: Codable, Hashable {
    public let error: String
    public let errorDescription: String

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case errorDescription = "error_description"
    }

    public init(error: String, errorDescription: String) {
        self.error = error
        self.errorDescription = errorDescription
    }
}

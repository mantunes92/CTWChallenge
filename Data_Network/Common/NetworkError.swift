//
//  NetworkError.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/26/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case error(Error)
    case serverError(ErrorDto)
    case withMessage(String)
    case generic

    public var errorDescription: String? {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .serverError(let errorDto):
            return "[\(errorDto.error)] --> \(errorDto.errorDescription)"
        case .withMessage(let message):
            return message
        case .generic:
            return "Generic Error"
        }
    }

}

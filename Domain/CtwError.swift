//
//  CtwError.swift
//  Domain
//
//  Created by Marcelo Antunes on 5/27/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public enum CtwError: Error, LocalizedError {
    case error(Error)
    case generic

    public var errorDescription: String? {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .generic:
            return "Generic Error"
        }
    }
}

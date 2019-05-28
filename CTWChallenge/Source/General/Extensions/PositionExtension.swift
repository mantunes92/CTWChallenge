//
//  PositionExtension.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain

extension Position {
    static var ctwHeadquarter: Position {
        return Position(latitude: 38.743961, longitude: -9.148526)
    }

    var prettyDescription: String {
        return "position.coordinates.pretty.description".localizedWithFormat(arguments: latitude, longitude)
    }
}

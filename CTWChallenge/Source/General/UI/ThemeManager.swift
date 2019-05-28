//
//  ThemeManager.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/22/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

class ThemeManager {
    static let shared: Theme = ThemeManager()

    private init() {}
}

extension ThemeManager: Theme {
    func primaryColor() -> UIColor {
        return UIColor.blueCtwColor
    }

    func secondaryColor() -> UIColor {
        return .blue
    }
}

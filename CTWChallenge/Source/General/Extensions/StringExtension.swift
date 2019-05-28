//
//  StringExtension.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    func localizedWithFormat(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}

//
//  UIColorExtension.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

extension UIColor {
    static let blueCtwColor = UIColor(r: 0, g: 0, b: 92)
}

private extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}

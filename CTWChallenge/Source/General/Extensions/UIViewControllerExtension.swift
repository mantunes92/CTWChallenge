//
//  UIViewControllerExtension.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/22/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

extension UIViewController {
    static func makeFromXib() -> Self {
        return makeFromOwnXib()
    }

    private static func makeFromOwnXib<Type>() -> Type {
        return (self.init(nibName: String(describing: self), bundle: nil) as? Type)!
    }
}

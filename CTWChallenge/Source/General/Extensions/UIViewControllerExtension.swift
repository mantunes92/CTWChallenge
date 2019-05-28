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

    func showLoading(_ show: Bool) {
        show ? view.showLoading()  : view.hideLoading()
    }



    func presentError(_ error: Error) {
        let alertVC = UIAlertController(title: "error.title".localized,
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)

        let okAction = UIAlertAction(title: "ok.btn.title".localized,
                                     style: .default)

        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}

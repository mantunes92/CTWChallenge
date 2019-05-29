//
//  UIViewExtension.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/22/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

extension UIView {
    static var name: String {
        return String(describing: self)
    }

    static func makeFromXib(withOwner owner: Any? = nil) -> Self {
        return makeFromXib(owner: owner)
    }

    private static func makeFromXib<Type>(owner: Any?) -> Type {
        let nibName = String(describing: self)
        let mainBundle = Bundle.main
        let arrayOfViews = mainBundle.loadNibNamed(nibName, owner: owner, options: nil) ?? []
        let view = arrayOfViews.compactMap({ $0 as? Type }).first
        if view == nil {
            fatalError("Linkage to Xib \(nibName) missing.")
        }
        return view!
    }

    func showLoading() {
        let loadingView: LoadingView = LoadingView.makeFromXib()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingView)

        loadingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        loadingView.activityIndicator.startAnimating()
    }

    func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

        _ = subviews.filter { $0 is LoadingView }.map { view -> Void in
            view.removeFromSuperview()
        }

        _ = subviews.filter { !$0.isKind(of: LoadingView.self) }.map { view -> Void in
            view.hideLoading()
        }
    }
}


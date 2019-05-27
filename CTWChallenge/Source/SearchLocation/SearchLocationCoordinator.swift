//
//  SearchLocationCoordinator.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/22/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit
import Domain
import Data

class SearchLocationCoordinator: Coordinator {
    let navigationType: NavigationType
    var childCoordinators: [Coordinator]

    weak var delegate: CoordinatorDelegate?

    private let repoProvider: RepositoryProvider = RepositoryProviderImpl()

    init(navigationController: UINavigationController, delegate: CoordinatorDelegate? = nil) {
        self.navigationType = .navigationController(navigationController)
        self.childCoordinators = []
        self.delegate = delegate
    }

    func execute() {
        let searchLocationVC = SearchLocationVC.makeFromXib()
        searchLocationVC.viewModel = SearchLocationVM(repo: repoProvider.makeSuggestionsRepository())
        searchLocationVC.navigationDelegate = self

        navigationController?.setViewControllers([searchLocationVC], animated: false)
    }

}

// MARK: - SearchLocationNavigationDelegate
extension SearchLocationCoordinator: SearchLocationNavigationDelegate {

}

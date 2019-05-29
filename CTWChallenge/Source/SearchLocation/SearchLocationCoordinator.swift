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

    private let repoProvider: RepositoryProvider

    init(navigationController: UINavigationController,
         delegate: CoordinatorDelegate? = nil,
         repoProvider: RepositoryProvider) {
        self.navigationType = .navigationController(navigationController)
        self.childCoordinators = []
        self.delegate = delegate
        self.repoProvider = repoProvider
    }

    func execute() {
        let searchLocationVC = SearchLocationVC.makeFromXib()
        searchLocationVC.viewModel = SearchLocationVM(repo: repoProvider.makeSuggestionsRepository())
        searchLocationVC.navigationDelegate = self

        navigationController?.setViewControllers([searchLocationVC], animated: false)
    }

}

// MARK: - CoordinatorDelegate
extension SearchLocationCoordinator: CoordinatorDelegate {
    func didFinish(coordinator: Coordinator, arguments: [CoordinatorArgumentKey : Any]?) {
        removeChildCoordinator(coordinator)
    }
}

// MARK: - SearchLocationNavigationDelegate
extension SearchLocationCoordinator: SearchLocationNavigationDelegate {
    func didSelectLocation(_ locationId: String) {
        guard let navController = navigationController else { fatalError("NavigationController not set") }
        let detailCoord = LocationDetailCoordinator(locationId: locationId,
                                                    navigationController: navController,
                                                    delegate: self,
                                                    repoProvider: repoProvider)
        addChildCoordinator(detailCoord)
        detailCoord.execute()
    }

    func didPressFavorites() {
        guard let navController = navigationController else { fatalError("NavigationController not set") }
        let favoritesCoord = FavoritesCoordinator(navigationController: navController,
                                                  delegate: self,
                                                  repoProvider: repoProvider)
        addChildCoordinator(favoritesCoord)
        favoritesCoord.execute()
    }
}

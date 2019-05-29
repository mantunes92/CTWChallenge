//
//  FavoritesCoordinator.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/29/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import Data

class FavoritesCoordinator: Coordinator {
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
        let viewModel = FavoritesVM(repo: repoProvider.makeLocationRepository())
        let favoritesVC = FavoritesVC.makeFromXib()
        favoritesVC.navigationDelegate = self
        favoritesVC.viewModel = viewModel

        let navController = UINavigationController(rootViewController: favoritesVC)
        navigationController?.present(navController, animated: true, completion: nil)
    }

}

// MARK: - FavoritesNavigationDelegate
extension FavoritesCoordinator: FavoritesNavigationDelegate {
    func goBack() {
        delegate?.didFinish(coordinator: self, arguments: nil)
    }
}

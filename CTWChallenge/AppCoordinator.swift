//
//  AppCoordinator.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/22/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit
import Domain
import Data

class AppCoordinator: Coordinator {
    let navigationType: NavigationType
    var childCoordinators: [Coordinator]

    weak var delegate: CoordinatorDelegate?
    private let window: UIWindow

    private let repoProvider: RepositoryProvider = RepositoryProviderImpl()

    init(window: UIWindow, delegate: CoordinatorDelegate) {
        self.navigationType = .navigationController(UINavigationController())
        self.childCoordinators = []
        self.delegate = delegate
        self.window = window
    }

    func execute() {
        guard let navController = navigationController else { fatalError("NavigationController not set") }
        window.rootViewController = navController

        let initialCoordinator = makeSearchLocationCoordinator(navVC: navController)
        addChildCoordinator(initialCoordinator)
        initialCoordinator.execute()
    }

    private func makeSearchLocationCoordinator(navVC: UINavigationController) -> SearchLocationCoordinator {
        let searchLocationCoordinator = SearchLocationCoordinator(navigationController: navVC,
                                                                  delegate: self,
                                                                  repoProvider: repoProvider)
        return searchLocationCoordinator
    }
}

// MARK: - CoordinatorDelegate
extension AppCoordinator: CoordinatorDelegate {
    func didFinish(coordinator: Coordinator, arguments: [CoordinatorArgumentKey : Any]?) {
        removeChildCoordinator(coordinator)
    }
}

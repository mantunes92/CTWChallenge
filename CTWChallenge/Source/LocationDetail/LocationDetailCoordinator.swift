//
//  LocationDetailCoordinator.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import Data

class LocationDetailCoordinator: Coordinator {
    let navigationType: NavigationType
    var childCoordinators: [Coordinator]

    weak var delegate: CoordinatorDelegate?

    private let locationId: String
    private let repoProvider: RepositoryProvider = RepositoryProviderImpl()

    init(locationId: String, navigationController: UINavigationController, delegate: CoordinatorDelegate? = nil) {
        self.locationId = locationId
        self.navigationType = .navigationController(navigationController)
        self.childCoordinators = []
        self.delegate = delegate
    }

    func execute() {
        let viewModel = LocationDetailVM(repo: repoProvider.makeLocationDetailRepository(),
                                         locationId: locationId)
        let locationDetailVC = LocationDetailVC.makeFromXib()
        locationDetailVC.navigationDelegate = self
        locationDetailVC.viewModel = viewModel
        navigationController?.pushViewController(locationDetailVC, animated: true)
    }

}

// MARK: - LocationDetailNavigationDelegate
extension LocationDetailCoordinator: LocationDetailNavigationDelegate {
    func goBack() {
        delegate?.didFinish(coordinator: self, arguments: nil)
    }
}

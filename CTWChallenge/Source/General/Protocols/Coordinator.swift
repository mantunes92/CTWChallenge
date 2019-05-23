//
//  Coordinator.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/22/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

enum CoordinatorArgumentKey {
    // Example how to define arguments to pass when didFinish is called
    case argument1
    case argument2
}

enum NavigationType {
    // Add any other relevant navigation types
    case none
    case navigationController(UINavigationController)
}

protocol CoordinatorDelegate: class {
    func didFinish(coordinator: Coordinator, arguments: [CoordinatorArgumentKey: Any]?)
}

protocol Coordinator: class {

    var navigationType: NavigationType { get }
    var childCoordinators: [Coordinator] { get set }

    //Important: It must be weak
    var delegate: CoordinatorDelegate? { get set }

    func execute()
}

extension Coordinator {

    var navigationController: UINavigationController? {
        if case NavigationType.navigationController(let navigationController) = navigationType {
            return navigationController
        }
        return nil
    }

}

extension Coordinator {

    // Add a child coordinator to the parent
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }

    // Remove a child coordinator from the parent
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }

}


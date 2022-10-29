//
//  CoordinatorProtocol.swift
//  Coordinator
//
//  Created by Eraldo Jr. on 27/10/22.
//
//

import UIKit

@testable import Coordinator

internal final class FakeCoordinator: CoordinatorProtocol {

    internal var uuid = String(describing: FakeCoordinator.self)

    internal var parentCoordinator: CoordinatorProtocol?

    internal var children: [CoordinatorProtocol]

    internal var navigationController: UINavigationController

    internal init(navigationController: UINavigationController, parentCoordinator: CoordinatorProtocol?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.children = []
        self.handle(FakeCoordinatorEvent.event1)
    }

    internal func handle(_ event: CoordinatorEvent) {
        if let fake = event as? FakeCoordinatorEvent {
            switch fake {
            case .event1:
                handleEvent1()
            case .child:
                var parent = self
                let child = FakeCoordinator(navigationController: navigationController, parentCoordinator: parent)
                parent.appendChild(child)
            case .pop:
                popNavigation()
            case .dismiss:
                dismiss()
            }
            return
        }
        guard let parentCoordinator else {
            fatalError("event not found")
        }
        parentCoordinator.handle(event)
    }

}

// MARK: Extension - Navigation methods

extension FakeCoordinator {

    private func handleEvent1() {
        navigationController.pushViewController(UIViewController(), animated: false)
    }

    private func popNavigation() {
        navigationController.viewControllers.removeLast()
    }

    private func dismiss() {
        parentCoordinator?.removeChild(self)
    }

}

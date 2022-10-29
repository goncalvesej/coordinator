//
//  CoordinatorProtocol.swift
//  Coordinator
//
//  Created by Eraldo Jr. on 27/10/22.
//
//

import UIKit

public protocol CoordinatorProtocol {

    var uuid: String { get }
    var parentCoordinator: CoordinatorProtocol? { get set }
    var children: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }

    func handle(_ event: CoordinatorEvent)
    mutating func appendChild(_ coordinator: CoordinatorProtocol)
    mutating func removeChild(_ coordinator: CoordinatorProtocol)

}

extension CoordinatorProtocol {

    public mutating func appendChild(_ coordinator: CoordinatorProtocol) {
        children.append(coordinator)
    }

    public mutating func removeChild(_ coordinator: CoordinatorProtocol) {
        children.removeAll(where: { coo in
            coo.uuid == coordinator.uuid
        })
    }

}

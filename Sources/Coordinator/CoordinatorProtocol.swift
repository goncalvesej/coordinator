//
//  CoordinatorProtocol.swift
//  Coordinator
//
//  Created by Eraldo Jr. on 27/10/22.
//  Copyright © 2022 goncalvesej. All rights reserved.
//

import UIKit

internal protocol CoordinatorEvent {

}

internal protocol CoordinatorProtocol {

    var uuid: String { get }
    var parentCoordinator: CoordinatorProtocol? { get set }
    var children: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func handle(_ event: CoordinatorEvent)
    mutating func appendChild(_ coordinator: CoordinatorProtocol)
    mutating func removeChild(_ coordinator: CoordinatorProtocol)

}

extension CoordinatorProtocol {

    internal mutating func appendChild(_ coordinator: CoordinatorProtocol) {
        children.append(coordinator)
    }

    internal mutating func removeChild(_ coordinator: CoordinatorProtocol) {
        children.removeAll(where: { coo in
            coo.uuid == coordinator.uuid
        })
    }

}

//
//  FakeCoordinatorEvent.swift
//  
//
//  Created by Eraldo Jr. on 28/10/22.
//

import Foundation

@testable import Coordinator

internal enum FakeCoordinatorEvent: CoordinatorEvent {

    case event1, child, pop, dismiss

}

internal enum BadEvent: CoordinatorEvent {

    case foo

}

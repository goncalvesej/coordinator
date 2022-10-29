//
//  CoordinatorProtocol.swift
//  Coordinator
//
//  Created by Eraldo Jr. on 27/10/22.
// 
//

import UIKit
import XCTest

@testable import Coordinator

internal final class CoordinatorTests: XCTestCase {

    private var sut: CoordinatorProtocol!
    private var navigationController: UINavigationController!

    internal override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        sut = FakeCoordinator(navigationController: navigationController, parentCoordinator: nil)
    }

    internal override func tearDown() {
        super.tearDown()
        sut = nil
    }

    internal func testCoordinator() {
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        sut.handle(FakeCoordinatorEvent.event1)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 2)
        sut.handle(FakeCoordinatorEvent.pop)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
    }

    internal func testChildren() throws {
        XCTAssertEqual(sut.children.count, 0)
        sut.handle(FakeCoordinatorEvent.child)
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 2)

        let child = try XCTUnwrap(sut.children.first)
        child.handle(FakeCoordinatorEvent.pop)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)

        child.handle(FakeCoordinatorEvent.dismiss)
        XCTAssertEqual(sut.children.count, 0)
    }

}

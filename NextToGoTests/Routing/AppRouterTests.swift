//
//  AppRouterTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import SwiftUI
import XCTest

final class AppRouterTests: XCTestCase {
    private var navigationController: TestNavigationController!
    private var raceViewControllerFactory: TestRaceViewControllerFactory!
    private var filterViewControllerFactory: TestFilterViewControllerFactory!
    private var router: AppRouter!

    @MainActor override func setUp() {
        navigationController = .init()
        raceViewControllerFactory = .init(viewController: .init())
        filterViewControllerFactory = .init(viewController: .init())
        router = AppRouter(
            navigationController: navigationController,
            raceViewControllerFactory: raceViewControllerFactory,
            filterViewControllerFactory: filterViewControllerFactory
        )
    }

    override func tearDown() {
        navigationController = nil
        raceViewControllerFactory = nil
        filterViewControllerFactory = nil
        router = nil
    }

    @MainActor func test_routeToRace() {
        router.routeToRace()
        XCTAssertEqual(raceViewControllerFactory.makeCalls.count, 1)
        XCTAssertEqual(navigationController.pushCalls.count, 1)
        XCTAssertFalse(navigationController.pushCalls[0].animated)
        XCTAssertTrue(
            navigationController.pushCalls[0].viewController
            === raceViewControllerFactory.viewController
        )
    }

    @MainActor func test_routeToFilter() {
        router.routeToFilter(filter: .all, delegate: nil)
        XCTAssertEqual(filterViewControllerFactory.makeCalls.count, 1)
        XCTAssertEqual(filterViewControllerFactory.makeCalls[0].filter, .all)
        XCTAssertTrue(
            filterViewControllerFactory.makeCalls[0].router
            is AppRouter
        )
        XCTAssertNil(filterViewControllerFactory.makeCalls[0].delegate)
        XCTAssertEqual(navigationController.pushCalls.count, 1)
        XCTAssertTrue(navigationController.pushCalls[0].animated)
        XCTAssertTrue(
            navigationController.pushCalls[0].viewController
            === filterViewControllerFactory.viewController
        )
    }

    @MainActor func test_routeBack() {
        router.routeBack()
        XCTAssertEqual(navigationController.popCalls.count, 1)
        XCTAssertTrue(navigationController.popCalls[0])
    }
}

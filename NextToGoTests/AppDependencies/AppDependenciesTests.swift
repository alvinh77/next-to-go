//
//  AppDependenciesTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

@testable import NextToGo

import XCTest

final class AppDependenciesTests: XCTestCase {
    @MainActor func test_rootViewController() {
        let appDependencies = AppDependencies(
            appConfiguration: AppConfiguration(baseURL: "https://www.test.com"),
            navigationControllerFactory: TestNavigationControllerFactory(),
            raceViewControllerFactory: TestRaceViewControllerFactory()
        )
        XCTAssertEqual(
            appDependencies.appConfiguration.baseURL,
            "https://www.test.com"
        )
        XCTAssertTrue(appDependencies.rootViewController is TestNavigationController)
    }
}

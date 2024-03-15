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
            appConfiguration: AppConfiguration(
                baseURL: "https://www.test.com",
                refreshDurationInSeconds: 50,
                maxFetchCount: 100,
                maxReturnCount: 5
            ),
            appRouter: TestAppRouter(),
            navigationControllerFactory: TestNavigationControllerFactory(),
            navigationController: TestNavigationController()
        )
        XCTAssertEqual(
            appDependencies.appConfiguration.baseURL,
            "https://www.test.com"
        )
        XCTAssertEqual(
            appDependencies.appConfiguration.refreshDurationInSeconds,
            50.0
        )
        XCTAssertEqual(
            appDependencies.appConfiguration.maxFetchCount,
            100
        )
        XCTAssertEqual(
            appDependencies.appConfiguration.maxReturnCount,
            5
        )
        XCTAssertTrue(appDependencies.rootViewController is TestNavigationController)
    }
}

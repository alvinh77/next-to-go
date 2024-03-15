//
//  RaceViewControllerFactoryTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import SwiftUI
import XCTest

final class RaceViewControllerFactoryTests: XCTestCase {
    @MainActor func test_makeViewController() throws {
        let viewController = try XCTUnwrap(
            RaceViewControllerFactory(
                baseURL: "https://www.test.com",
                refreshDurationInSeconds: 1,
                maxFetchCount: 2,
                maxReturnCount: 3,
                serverSession: TestServerSession()
            ).makeRaceViewController(router: TestAppRouter())
            as? RaceHostingController<RaceScreen<RacePresenter>>
        )

        XCTAssertEqual(viewController.title, "Next To Go")
        XCTAssertNotNil(viewController.delegate)
    }
}

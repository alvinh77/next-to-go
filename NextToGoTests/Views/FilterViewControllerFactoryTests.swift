//
//  FilterViewControllerFactoryTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import SwiftUI
import XCTest

final class FilterViewControllerFactoryTests: XCTestCase {
    @MainActor func test_makeViewController() throws {
        let viewController = try XCTUnwrap(
            FilterViewControllerFactory()
                .makeFilterViewController(
                    filter: .none,
                    router: TestAppRouter(),
                    delegate: nil
                )
            as? RaceHostingController<FilterScreen<FilterPresenter>>
        )

        XCTAssertEqual(viewController.title, "Filters")
        XCTAssertNil(viewController.delegate)
    }
}

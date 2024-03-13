//
//  NavigationControllerFactoryTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

import NextToGo
import XCTest

final class NavigationControllerFactoryTests: XCTestCase {
    @MainActor func test_makeNavigationController() {
        let factory = NavigationControllerFactory()
        XCTAssertTrue(factory.makeNavigationController() is UINavigationController)
    }
}

//
//  DefaultAppDependenciesFactoryTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

@testable import NextToGo

import XCTest

final class DefaultAppDependenciesFactoryTests: XCTestCase {
    @MainActor func test_appDependencies() {
        let factory = DefaultAppDependenciesFactory()
        XCTAssertTrue(factory.appDependencies is AppDependencies)
    }
}

//
//  TaskFactoryTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 19/3/2024.
//

@testable import NextToGo

import XCTest

final class TaskFactoryTests: XCTestCase {
    func test_init() async {
        let task = TaskFactory().makeTask {
            return true
        }
        let value = await task.value
        XCTAssertTrue(value)
    }
}

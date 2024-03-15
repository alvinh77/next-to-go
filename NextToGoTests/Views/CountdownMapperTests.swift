//
//  CountdownMapperTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import XCTest

final class CountdownMapperTests: XCTestCase {
    func test_mapPositiveTimeInterval() {
        let date = Date()
        let startTime = Int(date.timeIntervalSince1970) + 3600
        let result = CountdownMapper().map(date: date, startTime: startTime)
        XCTAssertEqual(result, "01:00:00")
    }

    func test_mapNegativeTimeInterval() {
        let date = Date()
        let startTime = Int(date.timeIntervalSince1970) - 3600
        let result = CountdownMapper().map(date: date, startTime: startTime)
        XCTAssertEqual(result, "-01:00:00")
    }

    func test_mapZeroTimeInterval() {
        let date = Date()
        let startTime = Int(date.timeIntervalSince1970)
        let result = CountdownMapper().map(date: date, startTime: startTime)
        XCTAssertEqual(result, "00:00:00")
    }

    func test_mapLargeTimeInterval() {
        let date = Date()
        let startTime = Int(date.timeIntervalSince1970) + 366100
        let result = CountdownMapper().map(date: date, startTime: startTime)
        XCTAssertEqual(result, "101:41:40")
    }

    func test_mapNegativeLargeTimeInterval() {
        let date = Date()
        let startTime = Int(date.timeIntervalSince1970) - 366100
        let result = CountdownMapper().map(date: date, startTime: startTime)
        XCTAssertEqual(result, "-101:41:40")
    }
}

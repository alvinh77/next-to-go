//
//  RaceFilterTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import XCTest

final class RaceFilterTests: XCTestCase {
    func test_initWithCategoryId() {
        XCTAssertEqual(
            RaceFilter(categoryId: "9daef0d7-bf3c-4f50-921d-8e818c60fe61"),
            .greyhound
        )
        XCTAssertEqual(
            RaceFilter(categoryId: "161d9be2-e909-4326-8c2c-35ed71fb460b"),
            .harness
        )
        XCTAssertEqual(
            RaceFilter(categoryId: "4a2788f8-e825-4d36-9894-efd4baf1cfae"),
            .horse
        )
        XCTAssertNil(RaceFilter(categoryId: "unknown"))
    }

    func test_categoryId() {
        XCTAssertEqual(
            RaceFilter.greyhound.categoryId,
            "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
        )
        XCTAssertEqual(
            RaceFilter.harness.categoryId,
            "161d9be2-e909-4326-8c2c-35ed71fb460b"
        )
        XCTAssertEqual(
            RaceFilter.horse.categoryId,
            "4a2788f8-e825-4d36-9894-efd4baf1cfae"
        )
        XCTAssertEqual(
            RaceFilter(rawValue: 10).categoryId,
            "10"
        )
    }

    func test_name() {
        XCTAssertEqual(RaceFilter.greyhound.name, "Greyhound")
        XCTAssertEqual(RaceFilter.harness.name, "Harness")
        XCTAssertEqual(RaceFilter.horse.name, "Horse")
        XCTAssertEqual(RaceFilter(rawValue: 10).name, "10")
    }

    func test_categoryIds() {
        let filters: RaceFilter = [RaceFilter.greyhound, RaceFilter.horse]
        XCTAssertEqual(
            filters.categoryIds,
            [
                "9daef0d7-bf3c-4f50-921d-8e818c60fe61",
                "4a2788f8-e825-4d36-9894-efd4baf1cfae"
            ]
        )
        XCTAssertEqual(RaceFilter.none.categoryIds, [])
        XCTAssertEqual(RaceFilter.all.categoryIds, [])
    }
}

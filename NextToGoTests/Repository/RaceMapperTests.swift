//
//  RaceMapperTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

@testable import NextToGo

import XCTest

final class RaceMapperTests: XCTestCase {
    private var response = RaceResponse(
        identifiers: ["1", "2", "3", "4"],
        summariesDictionary: [
            "1": RaceResponse.Summary(
                identifier: "id1",
                categoryId: "9daef0d7-bf3c-4f50-921d-8e818c60fe61",
                meetingName: "name1",
                number: 11,
                advisedStart: 111
            ),
            "2": RaceResponse.Summary(
                identifier: "id2",
                categoryId: "161d9be2-e909-4326-8c2c-35ed71fb460b",
                meetingName: "name2",
                number: 22,
                advisedStart: 222
            ),
            "3": RaceResponse.Summary(
                identifier: "id3",
                categoryId: "4a2788f8-e825-4d36-9894-efd4baf1cfae",
                meetingName: "name3",
                number: 33,
                advisedStart: 333
            ),
            "4": RaceResponse.Summary(
                identifier: "id4",
                categoryId: "9daef0d7-bf3c-4f50-921d-8e818c60fe61",
                meetingName: "name4",
                number: 15,
                advisedStart: 444
            )
        ]
    )

    func test_map_whenNoFilterApplied() {
        let result = RaceMapper(
            dateProvider: { .init(timeIntervalSince1970: 200)}
        ).map(response, filter: .none, maxReturnCount: 5)
        XCTAssertEqual(result.items.count, 3)
        let lastItem = result.items[2]
        XCTAssertEqual(lastItem.id, "id4")
        XCTAssertEqual(lastItem.title, "Meeting Name: name4")
        XCTAssertEqual(lastItem.detail, "Greyhound Race Number: 15")
        XCTAssertEqual(lastItem.startTime, 444)
    }

    func test_map_whenAllFiltersApplied() {
        let result = RaceMapper(
            dateProvider: { .init(timeIntervalSince1970: 200)}
        ).map(response, filter: .all, maxReturnCount: 5)
        XCTAssertEqual(result.items.count, 3)
    }

    func test_map_whenGreyhoundFiltersApplied() {
        let result = RaceMapper(
            dateProvider: { .init(timeIntervalSince1970: 200)}
        ).map(response, filter: .greyhound, maxReturnCount: 5)
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items[0].id, "id4")
    }

    func test_map_whenHarnessFiltersApplied() {
        let result = RaceMapper(
            dateProvider: { .init(timeIntervalSince1970: 200)}
        ).map(response, filter: .harness, maxReturnCount: 5)
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items[0].id, "id2")
    }

    func test_map_whenHorseFiltersApplied() {
        let result = RaceMapper(
            dateProvider: { .init(timeIntervalSince1970: 200)}
        ).map(response, filter: .horse, maxReturnCount: 5)
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items[0].id, "id3")
    }
}

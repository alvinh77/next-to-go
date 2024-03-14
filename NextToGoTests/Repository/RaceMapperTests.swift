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
        identifiers: ["1", "2", "3"],
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
            )
        ]
    )

    func test_map_whenNoFilterApplied() {
        let result = RaceMapper().map(response, filter: .none)
        XCTAssertEqual(result.items.count, 3)
        let lastItem = result.items[2]
        XCTAssertEqual(lastItem.id, "id3")
        XCTAssertEqual(lastItem.title, "Meeting Name: name3")
        XCTAssertEqual(lastItem.detail, "Race Number: 33")
        XCTAssertEqual(lastItem.countdown, 333)
    }

    func test_map_whenAllFiltersApplied() {
        let result = RaceMapper().map(response, filter: .all)
        XCTAssertEqual(result.items.count, 3)
    }

    func test_map_whenGreyhoundFiltersApplied() {
        let result = RaceMapper().map(response, filter: .greyhound)
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items[0].id, "id1")
    }

    func test_map_whenHarnessFiltersApplied() {
        let result = RaceMapper().map(response, filter: .harness)
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items[0].id, "id2")
    }

    func test_map_whenHorseFiltersApplied() {
        let result = RaceMapper().map(response, filter: .horse)
        XCTAssertEqual(result.items.count, 1)
        XCTAssertEqual(result.items[0].id, "id3")
    }
}

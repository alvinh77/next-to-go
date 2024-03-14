//
//  RaceResponseTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

@testable import NextToGo

import XCTest

final class RaceResponseTests: XCTestCase {
    func test_initResponse_whenKeyIsMissing() throws {
        let jsonString = """
        {
          "data": {
            "next_to_go_ids_": ["id1"],
            "race_summaries": {
              "id1": {
                "race_id": "1",
                "category_id": "1",
                "meeting_name": "Meeting 1",
                "race_number": 1,
                "advertised_start": {"seconds": 123456}
              }
            }
          }
        }
        """
        let jsonData = try XCTUnwrap(jsonString.data(using: .utf8))
        do {
            _ = try JSONDecoder().decode(RaceResponse.self, from: jsonData)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_initResponse() throws {
        let jsonString = """
        {
          "data": {
            "next_to_go_ids": ["id1"],
            "race_summaries": {
              "id1": {
                "race_id": "1",
                "category_id": "1",
                "meeting_name": "Meeting 1",
                "race_number": 1,
                "advertised_start": {"seconds": 123456}
              }
            }
          }
        }
        """
        let jsonData = try XCTUnwrap(jsonString.data(using: .utf8))
        let response = try JSONDecoder().decode(RaceResponse.self, from: jsonData)
        XCTAssertEqual(response.identifiers, ["id1"])
        XCTAssertEqual(response.summariesDictionary.count, 1)
    }

    func test_initSummary_whenKeyIsMissing() throws {
        let jsonString = """
        {
          "race_id": "id1",
          "category_id": "category1",
          "meeting_name": "Meeting 1",
          "race_number": 1,
          "advertised_start": {"string": 123456}
        }
        """
        let jsonData = try XCTUnwrap(jsonString.data(using: .utf8))
        do {
            _ = try JSONDecoder().decode(RaceResponse.Summary.self, from: jsonData)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_initSummary() throws {
        let jsonString = """
        {
          "race_id": "id1",
          "category_id": "horse",
          "meeting_name": "name",
          "race_number": 1,
          "advertised_start": {"seconds": 123456}
        }
        """
        let jsonData = try XCTUnwrap(jsonString.data(using: .utf8))
        let summary = try JSONDecoder().decode(RaceResponse.Summary.self, from: jsonData)
        XCTAssertEqual(summary.identifier, "id1")
        XCTAssertEqual(summary.categoryId, "horse")
        XCTAssertEqual(summary.meetingName, "name")
        XCTAssertEqual(summary.number, 1)
        XCTAssertEqual(summary.advisedStart, 123456)
    }
}

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
            {\"status\":200,\"next_to_go_ids\":[\"1\",\"2\",\"3\"],
            \"race_summaries\":[{\"race_id\":\"1\",
            \"race_number\":1,\"advertised_start\":{\"seconds\":5},}]}
        """
        let jsonData = try XCTUnwrap(jsonString.data(using: .utf8))
        do {
            _ = try JSONDecoder().decode(RaceResponse.Summary.self, from: jsonData)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_initResponse() throws {
        let jsonString = """
            {\"status\":200,\"next_to_go_ids\":[\"1\",\"2\",\"3\"],
            \"race_summaries\":[{\"race_id\":\"1\",\"meeting_name\":\"name\",
            \"race_number\":1,\"advertised_start\":{\"seconds\":5},}]}
        """
        let jsonData = try XCTUnwrap(jsonString.data(using: .utf8))
        let response = try JSONDecoder().decode(RaceResponse.self, from: jsonData)
        XCTAssertEqual(response.statusCode, 200)
        XCTAssertEqual(response.identifiers, ["1", "2", "3"])
        XCTAssertEqual(response.summaries.count, 1)
    }

    func test_initSummary_whenKeyIsMissing() throws {
        let jsonString = """
            {\"race_id\":\"1\",\"meeting_name\":\"name\",
            \"race_number\":2,\"advertised_start\":{\"string\":1},}
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
            {\"race_id\":\"1\",\"meeting_name\":\"name\",
            \"race_number\":2,\"advertised_start\":{\"seconds\":3},}
        """
        let jsonData = try XCTUnwrap(jsonString.data(using: .utf8))
        let summary = try JSONDecoder().decode(RaceResponse.Summary.self, from: jsonData)
        XCTAssertEqual(summary.identifier, "1")
        XCTAssertEqual(summary.meetingName, "name")
        XCTAssertEqual(summary.number, 2)
        XCTAssertEqual(summary.advisedStart, 3)
    }
}

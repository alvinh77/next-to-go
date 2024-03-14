//
//  RaceRespositoryTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

@testable import NextToGo

import XCTest

final class RaceRespositoryTests: XCTestCase {
    private var mapper: TestRaceMapper!
    private var networkManager: TestNetworkManager<RaceResponse>!
    private var respository: RaceRespository!

    override func setUp() {
        mapper = .init()
        networkManager = .init(
            response: .init(
                identifiers: [],
                summariesDictionary: [:]
            )
        )
        respository = .init(
            baseURL: "https://www.test.com",
            mapper: mapper,
            networkManager: networkManager
        )
    }

    override func tearDown() {
        mapper = nil
        networkManager = nil
        respository = nil
    }

    func test_fetchRaces() async throws {
        let model = try await respository.fetchRaces(filter: .all, forceUpdate: false)
        XCTAssertEqual(networkManager.dataCalls.count, 1)
        let dataCall = networkManager.dataCalls[0]
        XCTAssertEqual(dataCall.baseURL, "https://www.test.com")
        XCTAssertEqual(dataCall.method, .get)
        XCTAssertEqual(dataCall.path, "/rest/v1/racing/?method=nextraces&count=10")
        XCTAssertEqual(model.items.count, 1)
        XCTAssertEqual(mapper.mapCalls.count, 1)
        let mapCall = mapper.mapCalls[0]
        XCTAssertEqual(mapCall.filter, .all)
        XCTAssertEqual(mapCall.response.identifiers, [])
    }

    func test_fetchRaces_whenCacheIsAvailableButForceUpdate() async throws {
        _ = try await respository.fetchRaces(filter: .all, forceUpdate: false)
        _ = try await respository.fetchRaces(filter: .all, forceUpdate: true)
        XCTAssertEqual(networkManager.dataCalls.count, 2)
        XCTAssertEqual(mapper.mapCalls.count, 2)
    }

    func test_fetchRaces_whenCacheIsAvailableButDoesNotForceUpdate() async throws {
        _ = try await respository.fetchRaces(filter: .none, forceUpdate: true)
        _ = try await respository.fetchRaces(filter: .none, forceUpdate: false)
        XCTAssertEqual(networkManager.dataCalls.count, 1)
        XCTAssertEqual(mapper.mapCalls.count, 2)
    }

    func test_fetchRaces_whenNetworkError() async {
        networkManager.error = APIError.networking
        do {
            _ = try await respository.fetchRaces(filter: .horse, forceUpdate: true)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertEqual(error as? APIError, .networking)
        }
        XCTAssertEqual(networkManager.dataCalls.count, 1)
        XCTAssertEqual(mapper.mapCalls.count, 0)
    }
}

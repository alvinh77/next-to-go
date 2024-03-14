//
//  NetworkManagerTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

@testable import NextToGo

import XCTest

final class NetworkManagerTests: XCTestCase {
    private var manager: NetworkManager!
    private var serverSession: TestServerSession!

    override func setUp() {
        serverSession = .init()
        manager = .init(serverSession: serverSession)
    }

    override func tearDown() {
        manager = nil
        serverSession = nil
    }

    func test_data_callsServerSession() async {
        let request = APIRequest(baseURL: "https://www.test.com", path: "/api", method: .get)
        let _: TestModel? = try? await manager.data(from: request)
        let dataCalls = serverSession.dataCalls
        XCTAssertEqual(dataCalls.count, 1)
        XCTAssertEqual(dataCalls[0].url?.absoluteString, "https://www.test.com/api")
        XCTAssertEqual(dataCalls[0].httpMethod, "GET")
    }

    func test_data_whenURLIsInvalid() async {
        let request = APIRequest(baseURL: "", path: "", method: .get)
        do {
            let _: TestModel = try await manager.data(from: request)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertEqual(
                error as? APIError,
                .invalidURL
            )
        }
    }

    func test_data_whenServerSessionThrowsError() async {
        let request = APIRequest(baseURL: "https://www.test.com", path: "/api", method: .get)
        serverSession.error = .init()
        do {
            let _: TestModel = try await manager.data(from: request)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertEqual(
                error as? APIError,
                .networking
            )
        }
    }

    func test_data_whenStatusCodeInvalid() async throws {
        let request = APIRequest(baseURL: "https://www.test.com", path: "/api", method: .get)
        serverSession.urlResponse = try XCTUnwrap(
            .init(
                url: XCTUnwrap(.init(string: "https://www.test.com")),
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil
            )
        )
        do {
            let _: TestModel = try await manager.data(from: request)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertEqual(
                error as? APIError,
                .networking
            )
        }
    }

    func test_data_whenThrowDecodingError() async throws {
        let request = APIRequest(baseURL: "https://www.test.com", path: "/api", method: .get)
        do {
            let _: TestModel = try await manager.data(from: request)
            XCTFail("An error is expected to be thrown")
        } catch {
            XCTAssertEqual(
                error as? APIError,
                .decoding
            )
        }
    }

    func test_data_whenSuccess() async throws {
        let request = APIRequest(baseURL: "https://www.test.com", path: "/api", method: .get)
        serverSession.data = try JSONEncoder().encode(TestModel(name: "name"))
        let model: TestModel = try await manager.data(from: request)
        XCTAssertEqual(model.name, "name")
    }
}

extension NetworkManagerTests {
    private struct TestModel: Codable {
        let name: String
    }
}

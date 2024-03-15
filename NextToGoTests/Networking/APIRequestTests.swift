//
//  APIRequestTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import XCTest

final class APIRequestTests: XCTestCase {
    func test_initURLRequest() throws {
        let baseURL = "https://example.com/api"
        let path = "/users"
        let method = APIRequest.Method.get
        let parameters: [String: String]? = ["id": "123"]
        let request = APIRequest(baseURL: baseURL, path: path, method: method, parameters: parameters)
        let urlRequest = try URLRequest(request: request)
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/api/users?id=123")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
}

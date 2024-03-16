//
//  APIRequest.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public struct APIRequest: Sendable {
    public let baseURL: String
    public let path: String
    public let method: Method
    public let parameters: [String: String]?

    public init(
        baseURL: String,
        path: String,
        method: Method,
        parameters: [String: String]? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.parameters = parameters
        self.method = method
    }
}

extension APIRequest {
    public enum Method: String, Sendable {
        case get = "GET"
    }
}

// MARK: - Helper

extension URLRequest {
    public init(request: APIRequest) throws {
        let url: URL = try {
            switch request.method {
            case .get:
                guard var urlComponents = URLComponents(
                    string: "\(request.baseURL)\(request.path)"
                ) else {
                    /*
                     Discussion: Seems it is hard to get into this scenario
                     because `URLComponents(string:)` will always be non-nil
                     even if `URLComponents(string: "")`.
                     See `APIRequestTests` for more information.
                     TODO: Need more investigation on this to cover the tests
                     */
                    throw APIError.invalidURL
                }
                urlComponents.queryItems = request.parameters?.map { key, value in
                    URLQueryItem(name: key, value: value)
                }
                guard let url = urlComponents.url else {
                    /*
                     Same as above
                     */
                    throw APIError.invalidURL
                }
                return url
            }
        }()
        self.init(url: url)
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.httpMethod = request.method.rawValue
    }
}

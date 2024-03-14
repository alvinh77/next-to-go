//
//  APIRequest.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public struct APIRequest: Sendable {
    public let baseURL: String
    public let path: String
    public let method: Method

    public init(
        baseURL: String,
        path: String,
        method: Method
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
    }
}

extension APIRequest {
    public enum Method: String, Sendable {
        case get = "GET"
    }
}

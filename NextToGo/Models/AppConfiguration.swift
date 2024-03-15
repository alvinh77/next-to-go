//
//  AppConfiguration.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public struct AppConfiguration {
    public let baseURL: String
    public let maxFetchCount: Int
    public let maxReturnCount: Int

    public init(baseURL: String, maxFetchCount: Int, maxReturnCount: Int) {
        self.baseURL = baseURL
        self.maxFetchCount = maxFetchCount
        self.maxReturnCount = maxReturnCount
    }
}

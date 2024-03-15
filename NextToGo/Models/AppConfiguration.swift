//
//  AppConfiguration.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public struct AppConfiguration {
    public let baseURL: String
    public let refreshDurationInSeconds: TimeInterval
    public let maxFetchCount: Int
    public let maxReturnCount: Int

    public init(
        baseURL: String,
        refreshDurationInSeconds: TimeInterval,
        maxFetchCount: Int,
        maxReturnCount: Int
    ) {
        self.baseURL = baseURL
        self.refreshDurationInSeconds = refreshDurationInSeconds
        self.maxFetchCount = maxFetchCount
        self.maxReturnCount = maxReturnCount
    }
}

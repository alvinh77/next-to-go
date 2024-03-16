//
//  AppConfiguration.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

/*
 This configuration can be potentially read from
 remote configuration platform eg. LaunchDarkly
 or local one eg. configuration files in codebase.
 */
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

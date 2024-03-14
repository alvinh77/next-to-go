//
//  RaceFilter.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public struct RaceFilter: OptionSet, Sendable {
    public let rawValue: Int
    public static let greyhound = RaceFilter(rawValue: 1 << 0)
    public static let harness = RaceFilter(rawValue: 1 << 1)
    public static let horse = RaceFilter(rawValue: 1 << 2)
    public static let all: RaceFilter = [.greyhound, .harness, .horse]
    public static let none: RaceFilter = []

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

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

// MARK: - Helper

extension RaceFilter {
    public static var allAvaliableCases: [RaceFilter] {
        [.greyhound, .harness, .horse]
    }

    public var categoryId: String {
        switch self {
        case .greyhound:
            return "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
        case .harness:
            return "161d9be2-e909-4326-8c2c-35ed71fb460b"
        case .horse:
            return "4a2788f8-e825-4d36-9894-efd4baf1cfae"
        default:
            return "\(self.rawValue)"
        }
    }

    public var name: String {
        switch self {
        case .greyhound:
            return "Greyhound"
        case .harness:
            return "Harness"
        case .horse:
            return "Horse"
        default:
            return "\(self.rawValue)"
        }
    }

    public var categoryIds: [String] {
        if self == .none || self == .all { return [] }
        return RaceFilter.allAvaliableCases.compactMap {
            guard contains($0) else {
                return nil
            }
            return $0.categoryId
        }
    }

    public init?(categoryId: String) {
        switch categoryId {
        case RaceFilter.greyhound.categoryId:
            self = .greyhound
        case RaceFilter.harness.categoryId:
            self = .harness
        case RaceFilter.horse.categoryId:
            self = .horse
        default:
            return nil
        }
    }
}

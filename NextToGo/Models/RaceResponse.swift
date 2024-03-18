//
//  RaceResponse.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public struct RaceResponse: Decodable, Sendable {
    public let identifiers: [String]
    public let summariesDictionary: [String: Summary]

    public enum DataKeys: String, CodingKey {
        case data
    }

    public enum CodingKeys: String, CodingKey {
        case identifiers = "next_to_go_ids"
        case summariesDictionary = "race_summaries"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DataKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.identifiers = try dataContainer.decode([String].self, forKey: .identifiers)
        self.summariesDictionary = try dataContainer.decode([String: Summary].self, forKey: .summariesDictionary)
    }

    public init(
        identifiers: [String],
        summariesDictionary: [String: Summary]
    ) {
        self.identifiers = identifiers
        self.summariesDictionary = summariesDictionary
    }
}

extension RaceResponse {
    public struct Summary: Decodable, Sendable {
        let identifier: String
        let categoryId: String
        let meetingName: String
        let number: Int
        let advisedStart: Int

        // swiftlint:disable:next nesting
        public enum CodingKeys: String, CodingKey {
            case identifier = "race_id"
            case categoryId = "category_id"
            case meetingName = "meeting_name"
            case number = "race_number"
            case advisedStart = "advertised_start"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.identifier = try container.decode(String.self, forKey: .identifier)
            self.categoryId = try container.decode(String.self, forKey: .categoryId)
            self.meetingName = try container.decode(String.self, forKey: .meetingName)
            self.number = try container.decode(Int.self, forKey: .number)
            let advisedStartDictionary = try container.decode([String: Int].self, forKey: .advisedStart)
            guard let advisedStart = advisedStartDictionary["seconds"] else {
                throw DecodingError.keyNotFound(
                    CodingKeys.advisedStart,
                    .init(
                        codingPath: [CodingKeys.advisedStart],
                        debugDescription: "advertised_start.seconds is missing"
                    )
                )
            }
            self.advisedStart = advisedStart
        }

        public init(
            identifier: String,
            categoryId: String,
            meetingName: String,
            number: Int,
            advisedStart: Int
        ) {
            self.identifier = identifier
            self.categoryId = categoryId
            self.meetingName = meetingName
            self.number = number
            self.advisedStart = advisedStart
        }
    }
}

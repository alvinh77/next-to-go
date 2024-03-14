//
//  RaceResponse.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public struct RaceResponse: Decodable {
    public let statusCode: Int
    public let identifiers: [String]
    public let summaries: [Summary]

    public enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case identifiers = "next_to_go_ids"
        case summaries = "race_summaries"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.identifiers = try container.decode([String].self, forKey: .identifiers)
        self.summaries = try container.decode([Summary].self, forKey: .summaries)
    }
}

extension RaceResponse {
    public struct Summary: Decodable {
        let identifier: String
        let meetingName: String
        let number: Int
        let advisedStart: Int

        public enum CodingKeys: String, CodingKey {
            case identifier = "race_id"
            case meetingName = "meeting_name"
            case number = "race_number"
            case advisedStart = "advertised_start"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.identifier = try container.decode(String.self, forKey: .identifier)
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
    }
}

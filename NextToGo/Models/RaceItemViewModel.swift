//
//  RaceItemViewModel.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public struct RaceItemViewModel: Identifiable, Sendable {
    public let id: String
    public let title: String
    public let detail: String
    public let startTime: Int

    public init(
        id: String,
        title: String,
        detail: String,
        startTime: Int
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.startTime = startTime
    }
}

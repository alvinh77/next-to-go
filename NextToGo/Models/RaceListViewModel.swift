//
//  RaceListViewModel.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public struct RaceListViewModel: Sendable {
    public let items: [RaceItemViewModel]

    public init(items: [RaceItemViewModel]) {
        self.items = items
    }
}

//
//  FilterListViewModel.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

public struct FilterListViewModel {
    public let items: [FilterItemViewModel]

    public init(items: [FilterItemViewModel]) {
        self.items = items
    }
}

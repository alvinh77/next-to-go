//
//  RaceMapper.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public protocol RaceMapping {
    func map(
        _ response: RaceResponse,
        filter: RaceFilter,
        maxReturnCount: Int
    ) -> RaceListViewModel
}

public struct RaceMapper: RaceMapping, @unchecked Sendable {
    private let dateProvider: () -> Date

    public init(
        dateProvider: @escaping () -> Date = { .now }
    ) {
        self.dateProvider = dateProvider
    }

    public func map(
        _ response: RaceResponse,
        filter: RaceFilter,
        maxReturnCount: Int
    ) -> RaceListViewModel {
        let dateInSeconds = dateProvider().timeIntervalSince1970
        var summaries = response.identifiers.compactMap {
            response.summariesDictionary[$0]
        }
        // Prepare filters for local filtering
        let categoryIds = filter.categoryIds
        if filter.categoryIds.count > 0 {
            summaries = summaries.filter {
                categoryIds.contains($0.categoryId)
            }
        }
        let items = summaries.compactMap { summary -> RaceItemViewModel? in
            // Filtered out already started races
            guard Double(summary.advisedStart) > dateInSeconds else { return nil }
            var detail = "Race Number: \(summary.number)"
            if let categoryName = RaceFilter(categoryId: summary.categoryId)?.name {
                detail = "\(categoryName) \(detail)"
            }
            return RaceItemViewModel(
                id: summary.identifier,
                title: "Meeting Name: \(summary.meetingName)",
                detail: detail,
                startTime: summary.advisedStart
            )
        }.prefix(maxReturnCount) // Only display the top N races in the list
        return RaceListViewModel(items: Array(items))
    }
}

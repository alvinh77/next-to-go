//
//  RaceMapper.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public protocol RaceMapping {
    func map(
        _ response: RaceResponse,
        filter: RaceFilter,
        maxReturnCount: Int
    ) -> RaceListViewModel
}

public struct RaceMapper: RaceMapping, Sendable {
    public init() {}

    public func map(
        _ response: RaceResponse,
        filter: RaceFilter,
        maxReturnCount: Int
    ) -> RaceListViewModel {
        var summaries = response.identifiers.compactMap {
            response.summariesDictionary[$0]
        }
        let categoryIds = filter.categoryIds
        if filter.categoryIds.count > 0 {
            summaries = summaries.filter {
                categoryIds.contains($0.categoryId)
            }
        }
        let items = summaries.map {
            var detail = "Race Number: \($0.number)"
            if let categoryName = RaceFilter(categoryId: $0.categoryId)?.name {
                detail = "\(categoryName) \(detail)"
            }
            return RaceItemViewModel(
                id: $0.identifier,
                title: "Meeting Name: \($0.meetingName)",
                detail: detail,
                countdown: $0.advisedStart
            )
        }.prefix(maxReturnCount)
        return RaceListViewModel(items: Array(items))
    }
}

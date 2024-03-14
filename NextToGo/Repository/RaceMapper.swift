//
//  RaceMapper.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public protocol RaceMapping {
    func map(_ response: RaceResponse, filter: RaceFilter) -> RaceListViewModel
}

public struct RaceMapper: RaceMapping, Sendable {
    public init() {}

    public func map(_ response: RaceResponse, filter: RaceFilter) -> RaceListViewModel {
        var summaries = response.identifiers.compactMap {
            response.summariesDictionary[$0]
        }
        let categoryIds = getCategoryIds(from: filter)
        if categoryIds.count > 0 {
            summaries = summaries.filter {
                categoryIds.contains($0.categoryId)
            }
        }
        let items = summaries.map {
            RaceItemViewModel(
                id: $0.identifier,
                title: "Meeting Name: \($0.meetingName)",
                detail: "Race Number: \($0.number)",
                countdown: $0.advisedStart
            )
        }
        return RaceListViewModel(items: items)
    }

    private func getCategoryIds(from filter: RaceFilter) -> [String] {
        if filter == .none || filter == .all { return [] }
        var result = [String]()
        if filter.contains(.greyhound) {
            result.append("9daef0d7-bf3c-4f50-921d-8e818c60fe61")
        }
        if filter.contains(.harness) {
            result.append("161d9be2-e909-4326-8c2c-35ed71fb460b")
        }
        if filter.contains(.horse) {
            result.append("4a2788f8-e825-4d36-9894-efd4baf1cfae")
        }
        return result
    }
}

//
//  TestRaceMapper.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

import NextToGo

public final class TestRaceMapper: RaceMapping, @unchecked Sendable {
    public private(set) var mapCalls = [MapCall]()
    public var viewModel: RaceListViewModel

    public init(
        viewModel: RaceListViewModel = .init(items: [
            .init(
                id: "1",
                title: "title",
                detail: "detail",
                countdown: 1
            )
        ])
    ) {
        self.viewModel = viewModel
    }

    public func map(_ response: RaceResponse, filter: RaceFilter) -> RaceListViewModel {
        mapCalls.append(.init(response: response, filter: filter))
        return viewModel
    }

    public struct MapCall {
        let response: RaceResponse
        let filter: RaceFilter
    }
}

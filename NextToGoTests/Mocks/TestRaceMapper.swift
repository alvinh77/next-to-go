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

    public func map(
        _ response: RaceResponse,
        filter: RaceFilter,
        maxReturnCount: Int
    ) -> RaceListViewModel {
        mapCalls.append(
            .init(
                response: response,
                filter: filter,
                maxReturnCount: maxReturnCount
            )
        )
        return viewModel
    }

    public struct MapCall {
        public let response: RaceResponse
        public let filter: RaceFilter
        public let maxReturnCount: Int
    }
}

//
//  TestRaceRespository.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

import NextToGo

public actor TestRaceRespository: RaceRespositoryProcotol {
    public private(set) var fetchCalls = [FetchParams]()
    private var viewModel: RaceListViewModel
    private var error: APIError?

    public init(
        viewModel: RaceListViewModel = .init(
            items: [
                .init(
                    id: "1",
                    title: "title",
                    detail: "detail",
                    startTime: 100
                )
            ]
        ),
        error: APIError? = nil
    ) {
        self.viewModel = viewModel
        self.error = error
    }

    public func fetchRaces(
        filter: RaceFilter,
        forceUpdate: Bool
    ) async throws -> RaceListViewModel {
        fetchCalls.append(.init(filter: filter, forceUpdate: forceUpdate))
        if let error { throw error }
        return viewModel
    }

    public func set(viewModel: RaceListViewModel) {
        self.viewModel = viewModel
    }

    public func set(error: APIError?) {
        self.error = error
    }
}

extension TestRaceRespository {
    public struct FetchParams {
        public let filter: RaceFilter
        public let forceUpdate: Bool
    }
}

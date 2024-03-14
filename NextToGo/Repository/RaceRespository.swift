//
//  RaceRespository.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public protocol RaceRespositoryProcotol {
    func fetchRaces(
        filter: RaceFilter,
        forceUpdate: Bool
    ) async throws -> RaceListViewModel
}

public actor RaceRespository: RaceRespositoryProcotol {
    private let baseURL: String
    private let networkManager: NetworkManaging
    private let mapper: RaceMapping
    private var cachedResponse: RaceResponse?

    public init(
        baseURL: String,
        mapper: RaceMapping,
        networkManager: NetworkManaging
    ) {
        self.baseURL = baseURL
        self.mapper = mapper
        self.networkManager = networkManager
    }

    public func fetchRaces(filter: RaceFilter, forceUpdate: Bool) async throws -> RaceListViewModel {
        let response: RaceResponse
        if !forceUpdate, let cachedResponse {
            response = cachedResponse
        } else {
            response = try await networkManager.data(
                from: APIRequest(
                    baseURL: baseURL,
                    path: "/rest/v1/racing/?method=nextraces&count=10",
                    method: .get
                )
            )
            self.cachedResponse = response
        }
        return mapper.map(response, filter: filter)
    }
}

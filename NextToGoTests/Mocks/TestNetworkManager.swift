//
//  TestNetworkManager.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation
import NextToGo

public final class TestNetworkManager<ResponseType>: NetworkManaging, @unchecked Sendable {
    public private(set) var dataCalls = [APIRequest]()
    public var response: ResponseType
    public var error: Error?

    public init(
        response: ResponseType,
        error: Error? = nil
    ) {
        self.response = response
        self.error = nil
    }

    public func data<Response>(from request: APIRequest) async throws -> Response {
        dataCalls.append(request)
        if let error { throw error }
        guard let response = response as? Response else {
            throw APIError.networking
        }
        return response
    }
}

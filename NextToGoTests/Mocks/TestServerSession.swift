//
//  TestServerSession.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation
import NextToGo

public final class TestServerSession: ServerSession, @unchecked Sendable {
    public private(set) var dataCalls: [URLRequest] = []
    public var data: Data
    public var urlResponse: HTTPURLResponse
    public var error: NSError?

    public init(
        data: Data = .init(),
        urlResponse: HTTPURLResponse = .init(),
        error: NSError? = nil
    ) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataCalls.append(request)
        if let error { throw error }
        return (data, urlResponse)
    }
}

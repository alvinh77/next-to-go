//
//  NetworkManager.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public protocol NetworkManaging: Sendable {
    func data<Response: Decodable>(from request: APIRequest) async throws -> Response
}

public struct NetworkManager: NetworkManaging {
    private let serverSession: ServerSession

    public init(serverSession: ServerSession) {
        self.serverSession = serverSession
    }

    public func data<Response: Decodable>(from request: APIRequest) async throws -> Response {
        let urlRequest = try URLRequest(request: request)
        let data = try await getResponse(from: urlRequest)
        return try decode(data)
    }

    private func getResponse(from request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await serverSession.data(for: request)
            // Filtered out non-2XX status code in response
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200...299).contains(statusCode) else {
                throw APIError.networking
            }
            return data
        } catch {
            throw APIError.networking
        }
    }

    private func decode<Response: Decodable>(_ data: Data) throws -> Response {
        do {
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            throw APIError.decoding
        }
    }
}

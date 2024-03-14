//
//  ServerSession.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public protocol ServerSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: ServerSession {}

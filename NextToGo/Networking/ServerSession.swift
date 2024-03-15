//
//  ServerSession.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

/*
 Wrapup protocol for `URLSession` which will be injected into app
 */
public protocol ServerSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: ServerSession {}

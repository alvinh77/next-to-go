//
//  APIError.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Foundation

public enum APIError: Error {
    case decoding
    case networking
    case invalidURL
}

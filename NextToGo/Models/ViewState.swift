//
//  ViewState.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public enum ViewState<Success: Sendable, Action: Sendable>: Sendable {
    case notStarted
    case loading
    case success(Success)
    case action(Action)

    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}

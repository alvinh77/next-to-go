//
//  ViewState.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public enum ViewState<Success, Action> {
    case notStarted
    case loading
    case success(Success)
    case action(Action)

    public var isNotStarted: Bool {
        switch self {
        case .notStarted:
            return true
        default:
            return false
        }
    }

    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

    public var isAction: Bool {
        switch self {
        case .action:
            return true
        default:
            return false
        }
    }

    public var successValue: Success? {
        switch self {
        case let .success(value):
            return value
        default:
            return nil
        }
    }

    public var actionValue: Action? {
        switch self {
        case let .action(value):
            return value
        default:
            return nil
        }
    }
}

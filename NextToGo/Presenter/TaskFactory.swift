//
//  TaskFactory.swift
//  NextToGo
//
//  Created by Alvin He on 16/3/2024.
//

public protocol TaskFactoryProtocol {
    func makeTask<Success: Sendable>(
        operation: @escaping @Sendable () async -> Success
    ) -> Task<Success, Never>
}

public struct TaskFactory: TaskFactoryProtocol {
    public init() {}

    public func makeTask<Success: Sendable>(
        operation: @escaping @Sendable () async -> Success
    ) -> Task<Success, Never> {
        Task(operation: operation)
    }
}

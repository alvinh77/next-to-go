//
//  TaskFactory.swift
//  NextToGo
//
//  Created by Alvin He on 16/3/2024.
//

/*
 This factory protocol and struct is made to be injected
 into `RacePresenter` which make it easier to test/valid
 the cancellation of inflight concurrent fetching. The
 cancellation may happen if the method `loadData` was called
 multiple times within short time period.
*/
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

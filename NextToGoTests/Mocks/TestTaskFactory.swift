//
//  TestTaskFactory.swift
//  NextToGoTests
//
//  Created by Alvin He on 16/3/2024.
//

import NextToGo

public final class TestTaskFactory: TaskFactoryProtocol {
    public private(set) var tasks = [Any]()

    public func makeTask<Success: Sendable>(
        operation: @escaping @Sendable () async -> Success
    ) -> Task<Success, Never> {
        let task = Task(operation: operation)
        tasks.append(task)
        return task
    }
}

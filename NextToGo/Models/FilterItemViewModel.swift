//
//  FilterItemViewModel.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

public struct FilterItemViewModel: Identifiable, @unchecked Sendable {
    public let id: String
    public let systemImageName: String
    public let title: String
    public let action: () -> Void

    public init(
        id: String,
        systemImageName: String,
        title: String,
        action: @escaping () -> Void = {}
    ) {
        self.id = id
        self.systemImageName = systemImageName
        self.title = title
        self.action = action
    }
}

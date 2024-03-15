//
//  ActionViewModel.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

public struct ActionViewModel {
    public let title: String
    public let detail: String
    public let actionTitle: String
    public let action: () -> Void

    public init(
        title: String,
        detail: String,
        actionTitle: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.detail = detail
        self.actionTitle = actionTitle
        self.action = action
    }
}

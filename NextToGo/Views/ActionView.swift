//
//  ActionView.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import SwiftUI

public struct ActionView: View {
    private let model: ActionViewModel

    public init(model: ActionViewModel) {
        self.model = model
    }

    public var body: some View {
        VStack(spacing: 16) {
            Text(model.title)
                .font(.systemTitle)
            Text(model.detail)
                .font(.systemBody)
            Button(model.actionTitle, action: model.action)
                .font(.systemTitle)
        }
    }
}

#Preview {
    ActionView(
        model: ActionViewModel(
            title: "Whoops!",
            detail: "An unexpected error found 🔧",
            actionTitle: "Try Again",
            action: {}
        )
    ).previewLayout(.sizeThatFits)
}

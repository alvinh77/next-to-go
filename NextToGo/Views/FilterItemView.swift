//
//  FilterItemView.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

import SwiftUI

public struct FilterItemView: View {
    private let model: FilterItemViewModel

    public init(model: FilterItemViewModel) {
        self.model = model
    }

    public var body: some View {
        HStack {
            Text(model.title)
                .font(.systemTitle)
            Spacer()
            Image(systemName: model.systemImageName)
                .font(.systemTitle)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            model.action()
        }
    }
}

#Preview {
    FilterItemView(
        model: FilterItemViewModel(
            id: "1",
            systemImageName: "checkmark.square",
            title: "Greyhound"
        )
    )
}

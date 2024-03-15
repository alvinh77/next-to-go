//
//  FilterListView.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

import SwiftUI

public struct FilterListView: View {
    private let model: FilterListViewModel

    public init(model: FilterListViewModel) {
        self.model = model
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(model.items) { itemModel in
                    FilterItemView(model: itemModel)
                        .frame(minHeight: 60)
                    Divider()
                }
            }
            .padding()
        }
    }
}

#Preview {
    FilterListView(
        model: FilterListViewModel(
            items: [
                FilterItemViewModel(
                    id: "1",
                    systemImageName: "checkmark.square",
                    title: "Greyhound"
                ),
                FilterItemViewModel(
                    id: "2",
                    systemImageName: "square",
                    title: "Harness"
                ),
                FilterItemViewModel(
                    id: "3",
                    systemImageName: "checkmark.square",
                    title: "Horse"
                )
            ]
        )
    )
}

//
//  RaceListView.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import SwiftUI

public struct RaceListView: View {
    private let model: RaceListViewModel

    public init(model: RaceListViewModel) {
        self.model = model
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(model.items) { itemModel in
                    RaceItemView(model: itemModel)
                    Divider()
                }
            }
            .padding()
        }
    }
}

#Preview {
    RaceListView(
        model: RaceListViewModel(
            items: (0...5).map {
                RaceItemViewModel(
                    id: "\($0)",
                    title: "Meeting Name \($0)",
                    detail: "Race Number \($0)",
                    countdown: 100 + $0
                )
            }
        )
    ).previewLayout(.sizeThatFits)
}

//
//  RaceListView.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import SwiftUI

public struct RaceListView: View {
    private let model: RaceListViewModel
    private let date: Date

    public init(
        model: RaceListViewModel,
        date: Date = .now
    ) {
        self.model = model
        self.date = date
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(model.items) { itemModel in
                    RaceItemView(model: itemModel, date: date)
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
                    startTime: 100 + $0
                )
            }
        ),
        date: .init(timeIntervalSince1970: 0)
    ).previewLayout(.sizeThatFits)
}

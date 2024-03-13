//
//  RaceItemView.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import SwiftUI

public struct RaceItemView: View {
    private let model: RaceItemViewModel

    public init(model: RaceItemViewModel) {
        self.model = model
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(model.title)
                    .font(.systemTitle)
                Text(model.detail)
                    .font(.systemBody)
            }
            Spacer()
            Label(
                title: {
                    Text("\(model.countdown)")
                        .font(.systemTitle)
                },
                icon: {
                    Image(systemName: "alarm")
                        .font(.systemTitle)
                }
            )
        }
    }
}

#Preview {
    RaceItemView(
        model: RaceItemViewModel(
            id: "1",
            title: "Meeting Name",
            detail: "Race Number",
            countdown: 100
        )
    ).previewLayout(.sizeThatFits)
}

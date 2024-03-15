//
//  RaceItemView.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import SwiftUI

public struct RaceItemView: View {
    private let model: RaceItemViewModel
    private let date: Date
    private let mapper: CountdownMapper = .init()

    public init(
        model: RaceItemViewModel,
        date: Date = .now
    ) {
        self.model = model
        self.date = date
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
                    Text("\(mapper.map(date: date, startTime: model.startTime))")
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
            startTime: 100
        ),
        date: .init(timeIntervalSince1970: 0)
    ).previewLayout(.sizeThatFits)
}

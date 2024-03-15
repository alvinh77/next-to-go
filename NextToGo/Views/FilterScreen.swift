//
//  FilterScreen.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

import Combine
import SwiftUI

public struct FilterScreen<Presenter: FilterPresenterProtocol>: View {

    @ObservedObject private var presenter: Presenter

    public init(presenter: Presenter) {
        self.presenter = presenter
    }

    public var body: some View {
        VStack(spacing: 0) {
            FilterListView(model: presenter.model)
            Spacer()
            Button {
                presenter.onApplyFilters()
            } label: {
                Text("Apply Filters")
                    .font(.systemTitle)
                    .tint(Color.white)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
            }
            .background(Color.orange.ignoresSafeArea())
        }
    }
}

// MARK: - Preview

struct FilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen(presenter: TestPresenter())
    }

    @MainActor private class TestPresenter: FilterPresenterProtocol {
        let model = FilterListViewModel(
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
        nonisolated func onApplyFilters() {}
    }
}


//
//  RaceScreen.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Combine
import SwiftUI

public struct RaceScreen<Presenter: RacePresenterProtocol>: View {

    @ObservedObject private var presenter: Presenter

    public init(presenter: Presenter) {
        self.presenter = presenter
    }

    public var body: some View {
        switch presenter.viewState {
        case .notStarted:
            EmptyView()
        case .loading:
            ProgressView()
                .controlSize(.large)
        case let .success(listViewModel):
            successView(listViewModel)
        case let .action(actionViewModel):
            ActionView(model: actionViewModel)
        }
    }
}

// MARK: - Helper

extension RaceScreen {
    private func successView(_ model: RaceListViewModel) -> some View {
        VStack(spacing: 0) {
            RaceListView(model: model)
            Button {
                presenter.onFilter()
            } label: {
                Text("Filters")
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

struct RaceScreen_Previews: PreviewProvider {
    typealias State = ViewState<RaceListViewModel, ActionViewModel>

    static var previews: some View {
        RaceScreen(presenter: TestPresenter(viewState: .notStarted))
        RaceScreen(presenter: TestPresenter(viewState: .loading))
        RaceScreen(presenter: TestPresenter(viewState: .success(successModel)))
        RaceScreen(presenter: TestPresenter(viewState: .action(actionModel)))
    }

    @MainActor private class TestPresenter: RacePresenterProtocol {
        let viewState: State
        init(
            viewState: State = .notStarted
        ) {
            self.viewState = viewState
        }
        nonisolated func loadData() {}
        nonisolated func onFilter() {}
    }

    static var successModel: RaceListViewModel {
        RaceListViewModel(
            items: (0...5).map {
                RaceItemViewModel(
                    id: "\($0)",
                    title: "Meeting Name \($0)",
                    detail: "Race Number \($0)",
                    countdown: 100 + $0
                )
            }
        )
    }

    static var actionModel: ActionViewModel {
        ActionViewModel(
            title: "Whoops!",
            detail: "An unexpected error found 🔧",
            actionTitle: "Try Again",
            action: {}
        )
    }
}

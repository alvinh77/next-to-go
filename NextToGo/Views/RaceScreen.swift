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
    @State private var currentDate: Date
    private let updateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let refreshTimer: Publishers.Autoconnect<Timer.TimerPublisher>

    public init(
        presenter: Presenter,
        currentDate: Date = .now,
        refreshDurationInSeconds: TimeInterval
    ) {
        self.presenter = presenter
        self.currentDate = currentDate
        self.refreshTimer = Timer.publish(
            every: refreshDurationInSeconds,
            on: .main,
            in: .common
        ).autoconnect()
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
            RaceListView(model: model, date: currentDate)
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
        .onReceive(updateTimer) { date in
            currentDate = date
        }
        .onReceive(refreshTimer) { _ in
            presenter.loadData()
        }
    }
}

// MARK: - Preview

struct RaceScreen_Previews: PreviewProvider {
    typealias State = ViewState<RaceListViewModel, ActionViewModel>

    static var previews: some View {
        RaceScreen(
            presenter: TestPresenter(viewState: .notStarted),
            refreshDurationInSeconds: 60
        )
        RaceScreen(
            presenter: TestPresenter(viewState: .loading),
            refreshDurationInSeconds: 60
        )
        RaceScreen(
            presenter: TestPresenter(viewState: .success(successModel)),
            refreshDurationInSeconds: 60
        )
        RaceScreen(
            presenter: TestPresenter(viewState: .action(actionModel)),
            refreshDurationInSeconds: 60
        )
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
                    startTime: 100 + $0
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

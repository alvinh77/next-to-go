//
//  RaceScreen.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Combine
import SwiftUI

public struct RaceScreen<Presenter: RacePresenterProtocol>: View {
    public typealias UpdateTimer = Publishers.Autoconnect<Timer.TimerPublisher>
    private let countdownTimer: UpdateTimer
    private let refreshTimer: UpdateTimer
    @ObservedObject private var presenter: Presenter
    @State private var currentDate: Date = .now

    public init(
        countdownTimer: UpdateTimer,
        refreshTimer: UpdateTimer,
        presenter: Presenter
    ) {
        self.countdownTimer = countdownTimer
        self.refreshTimer = refreshTimer
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
        .onReceive(countdownTimer) { date in
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
        makeScreen(viewState: .notStarted)
        makeScreen(viewState: .loading)
        makeScreen(viewState: .success(successModel))
        makeScreen(viewState: .action(actionModel))
    }

    private static func makeScreen(viewState: State) -> RaceScreen<TestPresenter> {
        RaceScreen(
            countdownTimer: Timer.publish(
                every: 1,
                on: .main,
                in: .common
            ).autoconnect(),
            refreshTimer: Timer.publish(
                every: 50,
                on: .main,
                in: .common
            ).autoconnect(),
            presenter: TestPresenter(viewState: viewState)
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

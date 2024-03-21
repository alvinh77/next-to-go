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
    @State private var currentDate: Date

    public init(
        currentDate: Date = .now,
        countdownTimerInterval: TimeInterval,
        refreshTimerInterval: TimeInterval,
        presenter: Presenter
    ) {
        _currentDate = State(initialValue: currentDate)
        self.countdownTimer = Timer.publish(
            every: countdownTimerInterval,
            on: .main,
            in: .common
        ).autoconnect()
        self.refreshTimer = Timer.publish(
            every: refreshTimerInterval,
            on: .main,
            in: .common
        ).autoconnect()
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

#if DEBUG
#Preview {
    makeScreen(viewState: .notStarted)
}

#Preview {
    makeScreen(viewState: .loading)
}

#Preview {
    makeScreen(
        viewState: .success(
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
        )
    )
}

#Preview {
    makeScreen(
        viewState: .action(
            ActionViewModel(
                title: "Whoops!",
                detail: "An unexpected error found 🔧",
                actionTitle: "Try Again",
                action: {}
            )
        )
    )
}

@MainActor private func makeScreen(
    viewState: ViewState<RaceListViewModel, ActionViewModel>
) -> RaceScreen<TestPresenter> {
    RaceScreen(
        currentDate: .now,
        countdownTimerInterval: 1,
        refreshTimerInterval: 60,
        presenter: TestPresenter(viewState: viewState)
    )
}

private class TestPresenter: RacePresenterProtocol {
    let viewState: ViewState<RaceListViewModel, ActionViewModel>
    init(
        viewState: ViewState<RaceListViewModel, ActionViewModel>
    ) {
        self.viewState = viewState
    }
    func loadData() {}
    func onFilter() {}
}
#endif

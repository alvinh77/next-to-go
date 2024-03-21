//
//  RaceScreenTests.swift
//  NextToGoSnapshotTests
//
//  Created by Alvin He on 20/3/2024.
//

@testable import NextToGo

import SnapshotTesting
import SwiftUI
import XCTest

typealias State = ViewState<RaceListViewModel, ActionViewModel>

final class RaceScreenTests: XCTestCase {
    @MainActor func test_notStarted() {
        let viewController = UIHostingController(rootView: makeScreen(viewState: .notStarted))
        snapshotTest(viewController: viewController)
    }

    @MainActor func test_loading() {
        let viewController = UIHostingController(rootView: makeScreen(viewState: .loading))
        snapshotTest(viewController: viewController)
    }

    @MainActor func test_success() {
        let viewController = UIHostingController(
            rootView: makeScreen(viewState: .success(successModel))
        )
        snapshotTest(viewController: viewController)
    }

    @MainActor func test_action() {
        let viewController = UIHostingController(
            rootView: makeScreen(viewState: .action(actionModel))
        )
        snapshotTest(viewController: viewController)
    }
}

extension RaceScreenTests {
    @MainActor private func makeScreen(viewState: State) -> RaceScreen<TestPresenter> {
        RaceScreen(
            currentDate: .init(timeIntervalSince1970: 0),
            countdownTimerInterval: 1,
            refreshTimerInterval: 50,
            presenter: TestPresenter(viewState: viewState)
        )
    }

    private class TestPresenter: RacePresenterProtocol {
        let viewState: State
        init(
            viewState: State = .notStarted
        ) {
            self.viewState = viewState
        }
        func loadData() {}
        func onFilter() {}
    }

    private var successModel: RaceListViewModel {
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

    private var actionModel: ActionViewModel {
        ActionViewModel(
            title: "Whoops!",
            detail: "An unexpected error found 🔧",
            actionTitle: "Try Again",
            action: {}
        )
    }
}

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
            RaceListView(model: listViewModel)
        case let .action(actionViewModel):
            ActionView(model: actionViewModel)
        }
    }
}

struct RaceScreen_Previews: PreviewProvider {
    typealias State = ViewState<RaceListViewModel, ActionViewModel>

    static var previews: some View {
        RaceScreen(presenter: TestPresenter(viewState: .notStarted))
        RaceScreen(presenter: TestPresenter(viewState: .loading))
        RaceScreen(presenter: TestPresenter(viewState: .success(successModel)))
        RaceScreen(presenter: TestPresenter(viewState: .action(actionModel)))
    }

    private class TestPresenter: RacePresenterProtocol {
        var viewState: State
        init(
            viewState: State = .notStarted
        ) {
            self.viewState = viewState
        }
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

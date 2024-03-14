//
//  RacePresenter.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Combine
import Foundation

public protocol RacePresenterProtocol: ObservableObject {
    var viewState: ViewState<RaceListViewModel, ActionViewModel> { get }
    func loadData()
}

public final class RacePresenter: RacePresenterProtocol, @unchecked Sendable {
    private let repository: RaceRespositoryProcotol
    private var filter: RaceFilter = .none
    private var inflightTask: Task<Void, Error>?

    @Published public private(set) var viewState: ViewState<RaceListViewModel, ActionViewModel> = .notStarted

    public init(repository: RaceRespositoryProcotol) {
        self.repository = repository
    }

    public func loadData() {
        inflightTask?.cancel()
        viewState = .loading
        inflightTask = Task { @MainActor [filter, repository, weak self] in
            do {
                let viewModel = try await repository.fetchRaces(filter: filter, forceUpdate: true)
                guard !Task.isCancelled else { return }
                guard viewModel.items.count > 0 else {
                    self?.viewState = .action(
                        ActionViewModel(
                            title: "Whoops!",
                            detail: "There is no data available at the moment",
                            actionTitle: "Try Again",
                            action: { [weak self] in self?.loadData() }
                        )
                    )
                    return
                }
                self?.viewState = .success(viewModel)
            } catch {
                guard !Task.isCancelled else { return }
                self?.viewState = .action(
                    ActionViewModel(
                        title: "Whoops!",
                        detail: "An unexpected error found 🔧",
                        actionTitle: "Try Again",
                        action: { [weak self] in self?.loadData() }
                    )
                )
            }
        }
    }
}

extension RacePresenter: ViewControllerLifecycleDelegate {
    public func viewDidLoad() {
        loadData()
    }
}

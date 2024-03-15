//
//  RacePresenter.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Combine
import Foundation

@MainActor public protocol RacePresenterProtocol: ObservableObject {
    var viewState: ViewState<RaceListViewModel, ActionViewModel> { get }
    func loadData()
    func onFilter()
}

public final class RacePresenter: RacePresenterProtocol {
    private let repository: RaceRespositoryProcotol
    private let router: RaceRouting
    private var filter: RaceFilter = .none
    private var inflightTask: Task<Void, Error>?

    @Published public private(set) var viewState: ViewState<RaceListViewModel, ActionViewModel> = .notStarted

    public init(
        repository: RaceRespositoryProcotol,
        router: RaceRouting
    ) {
        self.repository = repository
        self.router = router
    }

    public func loadData() {
        inflightTask?.cancel()
        viewState = .loading
        inflightTask = Task { [filter, repository, weak self] in
            do {
                let viewModel = try await repository.fetchRaces(filter: filter, forceUpdate: true)
                guard !Task.isCancelled else { return }
                guard viewModel.items.count > 0 else { self?.handleEmptyResult(); return }
                self?.viewState = .success(viewModel)
            } catch {
                guard !Task.isCancelled else { return }
                self?.handleErrorResult()
            }
        }
    }

    public func onFilter() {
        router.routeToFilter(filter: filter, delegate: self)
    }
}

// MARK: - ViewControllerLifecycleDelegate Conformance

extension RacePresenter: ViewControllerLifecycleDelegate {
    public func viewDidLoad() {
        loadData()
    }
}

// MARK: - ViewControllerLifecycleDelegate Conformance

extension RacePresenter: FilterAppliedActionDelegate {
    public func filterDidApply(filter: RaceFilter) {
        guard self.filter != filter else { return }
        self.filter = filter
        loadData()
    }
}

// MARK: - Helper

extension RacePresenter {
    private func handleEmptyResult() {
        viewState = .action(
            ActionViewModel(
                title: "Whoops!",
                detail: "There is no data available at the moment",
                actionTitle: "Try Again",
                action: { [weak self] in self?.loadData() }
            )
        )
    }

    private func handleErrorResult() {
        viewState = .action(
            ActionViewModel(
                title: "Whoops!",
                detail: "An unexpected error found 🔧",
                actionTitle: "Try Again",
                action: { [weak self] in self?.loadData() }
            )
        )
    }
}

//
//  FilterPresenter.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

import Combine

@MainActor public protocol FilterPresenterProtocol: ObservableObject {
    var model: FilterListViewModel { get }
    func onApplyFilters()
}

public final class FilterPresenter: FilterPresenterProtocol {
    private let router: PopRouting
    private weak var delegate: FilterAppliedActionDelegate?
    @Published private var filter: RaceFilter

    public init(
        filter: RaceFilter,
        router: PopRouting,
        delegate: FilterAppliedActionDelegate?
    ) {
        self.filter = filter
        self.router = router
        self.delegate = delegate
    }

    public var model: FilterListViewModel {
        return FilterListViewModel(
            items: RaceFilter.allAvaliableCases.map { availableFilter in
                FilterItemViewModel(
                    id: availableFilter.categoryId,
                    systemImageName: filter.contains(availableFilter)
                        ? "checkmark.square"
                        : "square",
                    title: availableFilter.name,
                    action: { [weak self] in self?.click(availableFilter) }
                )
            }
        )
    }

    public func onApplyFilters() {
        // Notify delegate (At the moment is `RacePresenter`)
        delegate?.filterDidApply(filter: filter)
        router.routeBack()
    }
}

// MARK: - Helper

extension FilterPresenter {
    private func click(_ clickedFilter: RaceFilter) {
        if filter.contains(clickedFilter) {
            filter.remove(clickedFilter)
        } else {
            filter.insert(clickedFilter)
        }
    }
}

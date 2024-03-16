//
//  AppRouter.swift
//  NextToGo
//
//  Created by Alvin He on 17/3/2024.
//

public struct AppRouter: AppRouting {
    private let navigationController: NavigationControllerProtocol
    private let raceViewControllerFactory: RaceViewControllerFactoryProtocol
    private let filterViewControllerFactory: FilterViewControllerFactoryProtocol

    public init(
        navigationController: NavigationControllerProtocol,
        raceViewControllerFactory: RaceViewControllerFactoryProtocol,
        filterViewControllerFactory: FilterViewControllerFactoryProtocol) {
        self.navigationController = navigationController
            self.raceViewControllerFactory = raceViewControllerFactory
        self.filterViewControllerFactory = filterViewControllerFactory
    }
}

extension AppRouter: OnboardingRouting {
    public func routeToRace() {
        let viewController = raceViewControllerFactory
            .makeRaceViewController(router: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension AppRouter: RaceRouting {
    public func routeToFilter(
        filter: RaceFilter,
        delegate: FilterAppliedActionDelegate?
    ) {
        let viewController = filterViewControllerFactory
            .makeFilterViewController(
                filter: filter,
                router: self,
                delegate: delegate
            )
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension AppRouter: PopRouting {
    public func routeBack() {
        _ = navigationController.popViewController(animated: true)
    }
}

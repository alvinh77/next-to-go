//
//  AppRouter.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

/*
 Will be injected into prenters to be responsible for routing
 */
@MainActor public protocol AppRouting: OnboardingRouting, RaceRouting, PopRouting {}

@MainActor public protocol OnboardingRouting {
    func routeToRace()
}

@MainActor public protocol RaceRouting {
    func routeToFilter(
        filter: RaceFilter,
        delegate: FilterAppliedActionDelegate?
    )
}

@MainActor public protocol PopRouting {
    func routeBack()
}

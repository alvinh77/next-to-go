//
//  TestAppRouter.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

import NextToGo

public final class TestAppRouter: AppRouting {
    public private(set) var routeToRaceCallsCount = 0
    public private(set) var routeToFilterCalls = [RouteToFilterParams]()
    public private(set) var routeBackCallsCount = 0

    public func routeToRace() {
        routeToRaceCallsCount += 1
    }

    public func routeToFilter(
        filter: RaceFilter,
        delegate: FilterAppliedActionDelegate?
    ) {
        routeToFilterCalls.append(.init(filter: filter, delegate: delegate))
    }

    public func routeBack() {
        routeBackCallsCount += 1
    }
}

extension TestAppRouter {
    public struct RouteToFilterParams {
        public let filter: RaceFilter
        public let delegate: FilterAppliedActionDelegate?
    }
}

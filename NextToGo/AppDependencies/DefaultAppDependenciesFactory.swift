//
//  DefaultAppDependenciesFactory.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import UIKit

public final class DefaultAppDependenciesFactory: AppDependenciesFactoryProtocol {
    public init() {}

    public var appDependencies: any AppDependenciesProtocol {
        /*
         This configuration can be potentially read from
         remote configuration platform eg. LaunchDarkly
         or local one eg. configuration files in codebase.
         */
        let configuration = AppConfiguration(
            baseURL: "https://api.neds.com.au",
            refreshDurationInSeconds: 50,
            maxFetchCount: 100,
            maxReturnCount: 5
        )
        let navigationControllerFactory = NavigationControllerFactory()
        let navigationController = navigationControllerFactory.makeNavigationController()
        return AppDependencies(
            appConfiguration: configuration,
            appRouter: AppRouter(
                navigationController: navigationController,
                raceViewControllerFactory: RaceViewControllerFactory(
                    baseURL: configuration.baseURL,
                    refreshDurationInSeconds: configuration.refreshDurationInSeconds,
                    maxFetchCount: configuration.maxFetchCount,
                    maxReturnCount: configuration.maxReturnCount,
                    serverSession: URLSession.shared
                ),
                filterViewControllerFactory: FilterViewControllerFactory()
            ),
            navigationControllerFactory: navigationControllerFactory,
            navigationController: navigationController
        )
    }
}

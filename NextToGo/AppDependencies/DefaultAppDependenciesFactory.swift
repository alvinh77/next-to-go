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
        let configuration = AppConfiguration(
            baseURL: "https://api.neds.com.au",
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

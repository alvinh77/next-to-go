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
        let configuration = AppConfiguration(baseURL: "https://api.neds.com.au")
        return AppDependencies(
            appConfiguration: configuration,
            navigationControllerFactory: NavigationControllerFactory(),
            raceViewControllerFactory: RaceViewControllerFactory(
                baseURL: configuration.baseURL,
                serverSession: URLSession.shared
            )
        )
    }
}

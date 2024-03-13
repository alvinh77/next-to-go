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
        AppDependencies(
            appConfiguration: AppConfiguration(baseURL: "https://api.neds.com.au/"),
            navigationControllerFactory: NavigationControllerFactory()
        )
    }
}

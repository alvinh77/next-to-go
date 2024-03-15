//
//  AppDependencies.swift
//  NextToGo
//
//  Created by Alvin He on 13/3/2024.
//

import UIKit

public final class AppDependencies: AppDependenciesProtocol {
    public let appConfiguration: AppConfiguration
    private let appRouter: AppRouting
    private let navigationControllerFactory: NavigationControllerFactoryProtocol
    private let navigationController: NavigationControllerProtocol

    public init(
        appConfiguration: AppConfiguration,
        appRouter: AppRouting,
        navigationControllerFactory: NavigationControllerFactoryProtocol,
        navigationController: NavigationControllerProtocol
    ) {
        self.appConfiguration = appConfiguration
        self.appRouter = appRouter
        self.navigationControllerFactory = navigationControllerFactory
        self.navigationController = navigationController
        // Display the race screen to window
        appRouter.routeToRace()
    }

    public var rootViewController: UIViewController {
        navigationController
    }
}

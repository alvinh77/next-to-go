//
//  AppDependencies.swift
//  NextToGo
//
//  Created by Alvin He on 13/3/2024.
//

import UIKit

public final class AppDependencies: AppDependenciesProtocol {
    public let appConfiguration: AppConfiguration
    private let navigationController: NavigationControllerProtocol
    private let navigationControllerFactory: NavigationControllerFactoryProtocol
    private let raceViewControllerFactory: RaceViewControllerFactoryProtocol

    public init(
        appConfiguration: AppConfiguration,
        navigationControllerFactory: NavigationControllerFactoryProtocol,
        raceViewControllerFactory: RaceViewControllerFactoryProtocol
    ) {
        self.appConfiguration = appConfiguration
        self.navigationControllerFactory = navigationControllerFactory
        self.raceViewControllerFactory = raceViewControllerFactory
        self.navigationController = navigationControllerFactory.makeNavigationController()
        self.navigationController.pushViewController(
            raceViewControllerFactory.makeRaceViewController(),
            animated: false
        )
    }

    public var rootViewController: UIViewController {
        navigationController
    }
}

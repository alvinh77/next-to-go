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

    public init(
        appConfiguration: AppConfiguration,
        navigationControllerFactory: NavigationControllerFactoryProtocol
    ) {
        self.appConfiguration = appConfiguration
        self.navigationControllerFactory = navigationControllerFactory
        self.navigationController = navigationControllerFactory.makeNavigationController()
    }

    public var rootViewController: UIViewController {
        navigationController
    }
}

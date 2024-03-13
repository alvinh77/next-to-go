//
//  NavigationControllerFactory.swift
//  NextToGo
//
//  Created by Alvin He on 13/3/2024.
//

import UIKit

@MainActor public protocol NavigationControllerFactoryProtocol {
    func makeNavigationController() -> NavigationControllerProtocol
}

public struct NavigationControllerFactory: NavigationControllerFactoryProtocol {
    public init() {}

    public func makeNavigationController() -> any NavigationControllerProtocol {
        let navController = UINavigationController()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        return navController
    }
}

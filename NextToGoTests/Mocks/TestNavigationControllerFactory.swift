//
//  TestNavigationControllerFactory.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

import NextToGo
import UIKit

public struct TestNavigationControllerFactory: NavigationControllerFactoryProtocol {
    public var navigationController: TestNavigationController

    public init(
        navigationController: TestNavigationController = .init()
    ) {
        self.navigationController = navigationController
    }

    public func makeNavigationController() -> any NavigationControllerProtocol {
        navigationController
    }
}

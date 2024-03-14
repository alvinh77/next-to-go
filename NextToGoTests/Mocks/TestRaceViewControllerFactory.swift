//
//  TestRaceViewControllerFactory.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

import NextToGo
import UIKit

public struct TestRaceViewControllerFactory: RaceViewControllerFactoryProtocol {
    public var viewController: UIViewController

    public init(
        viewController: UIViewController = .init()
    ) {
        self.viewController = viewController
    }

    public func makeRaceViewController() -> UIViewController {
        viewController
    }
}

//
//  TestRaceViewControllerFactory.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

import NextToGo
import UIKit

public final class TestRaceViewControllerFactory: RaceViewControllerFactoryProtocol {
    public private(set) var makeCalls = [RaceRouting]()
    public var viewController: UIViewController

    public init(
        viewController: UIViewController = .init()
    ) {
        self.viewController = viewController
    }

    public func makeRaceViewController(router: RaceRouting) -> UIViewController {
        makeCalls.append(router)
        return viewController
    }
}

//
//  TestFilterViewControllerFactory.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

import NextToGo
import UIKit

public final class TestFilterViewControllerFactory: FilterViewControllerFactoryProtocol {
    public private(set) var makeCalls = [MakeParams]()
    public var viewController: UIViewController

    public init(
        viewController: UIViewController = .init()
    ) {
        self.viewController = viewController
    }

    public func makeFilterViewController(
        filter: RaceFilter,
        router: PopRouting,
        delegate: FilterAppliedActionDelegate?
    ) -> UIViewController {
        makeCalls.append(.init(filter: filter, router: router, delegate: delegate))
        return viewController
    }
}

extension TestFilterViewControllerFactory {
    public struct MakeParams {
        let filter: RaceFilter
        let router: PopRouting
        let delegate: FilterAppliedActionDelegate?
    }
}

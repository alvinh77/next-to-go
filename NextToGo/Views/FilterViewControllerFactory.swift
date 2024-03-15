//
//  FilterViewControllerFactory.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

import UIKit
import SwiftUI

@MainActor public protocol FilterViewControllerFactoryProtocol {
    func makeFilterViewController(
        filter: RaceFilter,
        router: PopRouting,
        delegate: FilterAppliedActionDelegate?
    ) -> UIViewController
}

public struct FilterViewControllerFactory: FilterViewControllerFactoryProtocol {
    public init() {}

    public func makeFilterViewController(
        filter: RaceFilter,
        router: PopRouting,
        delegate: FilterAppliedActionDelegate?
    ) -> UIViewController {
        let presenter = FilterPresenter(
            filter: filter,
            router: router,
            delegate: delegate
        )
        let screen = FilterScreen(presenter: presenter)
        let viewController = RaceHostingController(rootView: screen)
        viewController.title = "Filters"
        return viewController
    }
}

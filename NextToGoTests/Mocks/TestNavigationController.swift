//
//  TestNavigationController.swift
//  NextToGoTests
//
//  Created by Alvin He on 14/3/2024.
//

import NextToGo
import UIKit

public final class TestNavigationController: UIViewController, NavigationControllerProtocol {
    public private(set) var pushCalls = [PushParams]()
    public private(set) var popCalls = [Bool]()

    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushCalls.append(.init(viewController: viewController, animated: animated))
    }

    public func popViewController(animated: Bool) -> UIViewController? {
        popCalls.append(animated)
        return nil
    }
}

extension TestNavigationController {
    public struct PushParams {
        public let viewController: UIViewController
        public let animated: Bool
    }
}

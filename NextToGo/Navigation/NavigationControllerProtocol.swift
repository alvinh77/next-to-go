//
//  NavigationControllerProtocol.swift
//  NextToGo
//
//  Created by Alvin He on 13/3/2024.
//

import UIKit

/*
 Wrapup protocol for `UINavigationController` which will be injected into app
 */
@MainActor public protocol NavigationControllerProtocol: UIViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
}

extension UINavigationController: NavigationControllerProtocol {}

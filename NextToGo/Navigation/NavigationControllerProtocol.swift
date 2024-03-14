//
//  NavigationControllerProtocol.swift
//  NextToGo
//
//  Created by Alvin He on 13/3/2024.
//

import UIKit

@MainActor public protocol NavigationControllerProtocol: UIViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

extension UINavigationController: NavigationControllerProtocol {}

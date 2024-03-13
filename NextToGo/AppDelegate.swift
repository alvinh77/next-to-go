//
//  AppDelegate.swift
//  NextToGo
//
//  Created by Alvin He on 13/3/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = makeWindow()
        return true
    }
}

// MARK: - Helper

extension AppDelegate {
    private func makeWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = makeNavigationController()
        window.makeKeyAndVisible()
        return window
    }

    private func makeNavigationController() -> UINavigationController {
        let navController = UINavigationController(rootViewController: makeRootViewController())
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        return navController
    }

    private func makeRootViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .orange
        return viewController
    }
}

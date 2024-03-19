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
    private func makeWindow() -> UIWindow? {
        guard ProcessInfo.processInfo.environment["isTest"] == nil else { return nil }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = getAppDependencies()?.rootViewController
        window.makeKeyAndVisible()
        return window
    }

    /*
     Here we read the `AppDepdencies` name from configuration file `DefaultConfiguration`.
     If we would like introduce more schemes eg. staging, we could make different app
     dependencies class (conforms to AppDependenciesProtocol) to be configurated into
     corresponding schemes. eg. Passing staging API url domain to scheme `staging` and
     production API url domain to scheme `release`
     */
    private func getAppDependencies() -> AppDependenciesProtocol? {
        guard let namespace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String
        else {
            assertionFailure("`namespace` is expected to exist")
            return nil
        }
        guard let appDependenciesFactoryClassName = Bundle.main
            .infoDictionary?["APP_DEPENDENCIES_FACTORY_CLASS_NAME"] as? String
        else {
            assertionFailure("`APP_DEPENDENCIES_FACTORY_CLASS_NAME` is expected to exist")
            return nil
        }
        guard let appDependenciesFactory = Bundle.main.classNamed(
            "\(namespace).\(appDependenciesFactoryClassName)"
        ) as? AppDependenciesFactoryProtocol.Type
        else {
            assertionFailure("`AppDependenciesFactory` is expected to exist")
            return nil
        }
        return appDependenciesFactory.init().appDependencies
    }
}

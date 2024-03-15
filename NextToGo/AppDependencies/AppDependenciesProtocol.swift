//
//  AppDependenciesProtocol.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import UIKit

@MainActor public protocol AppDependenciesProtocol {
    var appConfiguration: AppConfiguration { get }
    /*
     The root view controller of the application.
     Normally would be a `UINavigationController`
     */
    var rootViewController: UIViewController { get }
}

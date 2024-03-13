//
//  AppDependenciesFactoryProtocol.swift
//  NextToGo
//
//  Created by Alvin He on 13/3/2024.
//

import UIKit

@MainActor public protocol AppDependenciesFactoryProtocol {
    init()
    var appDependencies: AppDependenciesProtocol { get }
}

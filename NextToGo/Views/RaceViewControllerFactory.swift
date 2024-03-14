//
//  RaceViewControllerFactory.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import UIKit
import SwiftUI

@MainActor public protocol RaceViewControllerFactoryProtocol {
    func makeRaceViewController() -> UIViewController
}

public struct RaceViewControllerFactory: RaceViewControllerFactoryProtocol {
    private let baseURL: String
    private let serverSession: ServerSession

    public init(baseURL: String, serverSession: ServerSession) {
        self.baseURL = baseURL
        self.serverSession = serverSession
    }

    public func makeRaceViewController() -> UIViewController {
        let mapper = RaceMapper()
        let networkManager = NetworkManager(serverSession: serverSession)
        let repository = RaceRespository(baseURL: baseURL, mapper: mapper, networkManager: networkManager)
        let presenter = RacePresenter(repository: repository)
        let screen = RaceScreen(presenter: presenter)
        let viewController = RaceHostingController(rootView: screen)
        viewController.title = "Next To Go"
        viewController.delegate = presenter
        return viewController
    }
}

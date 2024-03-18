//
//  RaceViewControllerFactory.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import UIKit
import SwiftUI

@MainActor public protocol RaceViewControllerFactoryProtocol {
    func makeRaceViewController(router: RaceRouting) -> UIViewController
}

public struct RaceViewControllerFactory: RaceViewControllerFactoryProtocol {
    private let baseURL: String
    private let refreshDurationInSeconds: TimeInterval
    private let maxFetchCount: Int
    private let maxReturnCount: Int
    private let serverSession: ServerSession

    public init(
        baseURL: String,
        refreshDurationInSeconds: TimeInterval,
        maxFetchCount: Int,
        maxReturnCount: Int,
        serverSession: ServerSession
    ) {
        self.baseURL = baseURL
        self.refreshDurationInSeconds = refreshDurationInSeconds
        self.maxFetchCount = maxFetchCount
        self.maxReturnCount = maxReturnCount
        self.serverSession = serverSession
    }

    public func makeRaceViewController(router: RaceRouting) -> UIViewController {
        let networkManager = NetworkManager(serverSession: serverSession)
        let repository = RaceRespository(
            baseURL: baseURL,
            maxFetchCount: maxFetchCount,
            maxReturnCount: maxReturnCount,
            mapper: RaceMapper(),
            networkManager: networkManager
        )
        let presenter = RacePresenter(
            repository: repository,
            router: router,
            taskFactory: TaskFactory()
        )
        let screen = RaceScreen(
            countdownTimer: Timer.publish(
                every: 1,
                on: .main,
                in: .common
            ).autoconnect(),
            refreshTimer: Timer.publish(
                every: refreshDurationInSeconds,
                on: .main,
                in: .common
            ).autoconnect(),
            presenter: presenter
        )
        let viewController = RaceHostingController(rootView: screen)
        viewController.title = "Next To Go"
        viewController.delegate = presenter
        return viewController
    }
}

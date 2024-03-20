//
//  ActionViewSnapshotTests.swift
//  NextToGoSnapshotTests
//
//  Created by Alvin He on 19/3/2024.
//

@testable import NextToGo

import SnapshotTesting
import SwiftUI
import XCTest

final class ActionViewSnapshotTests: XCTestCase {
    @MainActor func test() throws {
        let model = ActionViewModel(
            title: "Whoops!",
            detail: "An unexpected error found 🔧",
            actionTitle: "Try Again",
            action: {}
        )
        let actionView = ActionView(model: model)
        snapshotTest(view: actionView)
    }
}

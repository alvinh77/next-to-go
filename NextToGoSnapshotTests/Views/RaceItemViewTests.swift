//
//  RaceItemViewTests.swift
//  NextToGoSnapshotTests
//
//  Created by Alvin He on 20/3/2024.
//

@testable import NextToGo

import SnapshotTesting
import SwiftUI
import XCTest

final class RaceItemViewTests: XCTestCase {
    @MainActor func test() throws {
        let model = RaceItemViewModel(
            id: "1",
            title: "Meeting Name",
            detail: "Race Number",
            startTime: 100
        )
        let view = RaceItemView(
            model: model,
            date: .init(timeIntervalSince1970: 0)
        )
        snapshotTest(view: view)
    }
}

//
//  RaceListViewTests.swift
//  NextToGoSnapshotTests
//
//  Created by Alvin He on 20/3/2024.
//

@testable import NextToGo

import SnapshotTesting
import SwiftUI
import XCTest

final class RaceListViewTests: XCTestCase {
    @MainActor func test() throws {
        let model = RaceListViewModel(
            items: (0...5).map {
                RaceItemViewModel(
                    id: "\($0)",
                    title: "Meeting Name \($0)",
                    detail: "Race Number \($0)",
                    startTime: 100 + $0
                )
            }
        )
        let view = RaceListView(
            model: model,
            date: .init(timeIntervalSince1970: 0)
        )
        snapshotTest(view: view)
    }
}

//
//  FilterListViewTests.swift
//  NextToGoSnapshotTests
//
//  Created by Alvin He on 20/3/2024.
//

@testable import NextToGo

import SnapshotTesting
import SwiftUI
import XCTest

final class FilterListViewTests: XCTestCase {
    @MainActor func test() throws {
        let model = FilterListViewModel(
            items: [
                FilterItemViewModel(
                    id: "1",
                    systemImageName: "checkmark.square",
                    title: "Greyhound"
                ),
                FilterItemViewModel(
                    id: "2",
                    systemImageName: "square",
                    title: "Harness"
                ),
                FilterItemViewModel(
                    id: "3",
                    systemImageName: "checkmark.square",
                    title: "Horse"
                )
            ]
        )
        let view = FilterListView(model: model)
        snapshotTest(view: view)
    }
}

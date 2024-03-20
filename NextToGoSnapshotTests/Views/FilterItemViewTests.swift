//
//  FilterItemViewTests.swift
//  NextToGoSnapshotTests
//
//  Created by Alvin He on 20/3/2024.
//

@testable import NextToGo

import SnapshotTesting
import SwiftUI
import XCTest

final class FilterItemViewTests: XCTestCase {
    @MainActor func test() throws {
        let model = FilterItemViewModel(
            id: "1",
            systemImageName: "checkmark.square",
            title: "Greyhound"
        )
        let view = FilterItemView(model: model)
        snapshotTest(view: view)
    }
}

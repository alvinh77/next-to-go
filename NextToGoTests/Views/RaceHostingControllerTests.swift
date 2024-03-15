//
//  RaceHostingControllerTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import SwiftUI
import XCTest

final class RaceHostingControllerTests: XCTestCase {
    @MainActor func test_viewDidLoad() {
        let delegate = Delegate()
        let viewController = RaceHostingController(rootView: Text(""))
        viewController.delegate = delegate
        viewController.viewDidLoad()
        XCTAssertEqual(delegate.viewDidLoadCalls, 1)
    }
}

extension RaceHostingControllerTests {
    private final class Delegate: ViewControllerLifecycleDelegate {
        var viewDidLoadCalls = 0
        func viewDidLoad() {
            viewDidLoadCalls += 1
        }
    }
}

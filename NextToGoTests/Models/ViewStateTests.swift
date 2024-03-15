//
//  ViewStateTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import XCTest

final class ViewStateTests: XCTestCase {
    typealias State = ViewState<Int, String>

    func test_isSuccess() {
        let successViewState = State.success(10)
        let notStartedViewState = State.notStarted
        let loadingViewState = State.loading
        let actionViewState = State.action("Action")

        XCTAssertTrue(successViewState.isSuccess)
        XCTAssertFalse(notStartedViewState.isSuccess)
        XCTAssertFalse(loadingViewState.isSuccess)
        XCTAssertFalse(actionViewState.isSuccess)
    }
}

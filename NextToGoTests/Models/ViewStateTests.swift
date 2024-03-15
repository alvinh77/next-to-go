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
    private let successViewState = State.success(10)
    private let notStartedViewState = State.notStarted
    private let loadingViewState = State.loading
    private let actionViewState = State.action("Action")

    func test_isNotStarted() {
        XCTAssertTrue(notStartedViewState.isNotStarted)
        XCTAssertFalse(loadingViewState.isNotStarted)
        XCTAssertFalse(successViewState.isNotStarted)
        XCTAssertFalse(actionViewState.isNotStarted)
    }

    func test_isLoading() {
        XCTAssertFalse(notStartedViewState.isLoading)
        XCTAssertTrue(loadingViewState.isLoading)
        XCTAssertFalse(successViewState.isLoading)
        XCTAssertFalse(actionViewState.isLoading)
    }

    func test_isSuccess() {
        XCTAssertFalse(notStartedViewState.isSuccess)
        XCTAssertFalse(loadingViewState.isSuccess)
        XCTAssertTrue(successViewState.isSuccess)
        XCTAssertFalse(actionViewState.isSuccess)
    }

    func test_isAction() {
        XCTAssertFalse(notStartedViewState.isAction)
        XCTAssertFalse(loadingViewState.isAction)
        XCTAssertFalse(successViewState.isAction)
        XCTAssertTrue(actionViewState.isAction)
    }

    func test_successValue() {
        XCTAssertNil(notStartedViewState.successValue)
        XCTAssertNil(loadingViewState.successValue)
        XCTAssertEqual(successViewState.successValue, 10)
        XCTAssertNil(actionViewState.successValue)
    }

    func test_actionValue() {
        XCTAssertNil(notStartedViewState.actionValue)
        XCTAssertNil(loadingViewState.actionValue)
        XCTAssertNil(successViewState.actionValue)
        XCTAssertEqual(actionViewState.actionValue, "Action")
    }
}

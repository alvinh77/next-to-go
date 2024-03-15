//
//  FilterPresenterTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import XCTest

final class FilterPresenterTests: XCTestCase {
    private var router: TestAppRouter!
    private var delegate: Delegate!
    private var presenter: FilterPresenter!

    @MainActor override func setUp() {
        router = .init()
        delegate = .init()
        presenter = .init(
            filter: .greyhound,
            router: router,
            delegate: delegate
        )
    }

    override func tearDown() {
        router = nil
        delegate = nil
        presenter = nil
    }

    @MainActor func test_model() {
        let model = presenter.model
        XCTAssertEqual(model.items.count, 3)
        XCTAssertEqual(
            model.items.map { $0.id },
            [
                "9daef0d7-bf3c-4f50-921d-8e818c60fe61",
                "161d9be2-e909-4326-8c2c-35ed71fb460b",
                "4a2788f8-e825-4d36-9894-efd4baf1cfae"
            ]
        )
        XCTAssertEqual(
            model.items.map { $0.title },
            ["Greyhound", "Harness", "Horse"]
        )
        XCTAssertEqual(
            model.items.map { $0.systemImageName },
            ["checkmark.square", "square", "square"]
        )
    }

    @MainActor func test_applyFilters() {
        let model = presenter.model
        _ = model.items.map { $0.action() }
        presenter.onApplyFilters()
        XCTAssertEqual(router.routeBackCallsCount, 1)
        XCTAssertEqual(delegate.didApplyCalls.count, 1)
        XCTAssertEqual(delegate.didApplyCalls[0], [.harness, .horse])
    }
}

extension FilterPresenterTests {
    private final class Delegate: FilterAppliedActionDelegate {
        private(set) var didApplyCalls = [RaceFilter]()

        func filterDidApply(filter: RaceFilter) {
            didApplyCalls.append(filter)
        }
    }
}

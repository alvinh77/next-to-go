//
//  RacePresenterTests.swift
//  NextToGoTests
//
//  Created by Alvin He on 15/3/2024.
//

@testable import NextToGo

import XCTest

final class RacePresenterTests: XCTestCase {
    private var repository: TestRaceRespository!
    private var router: TestAppRouter!
    private var taskFactory: TestTaskFactory!
    private var presenter: RacePresenter!

    @MainActor override func setUp() {
        repository = .init()
        router = .init()
        taskFactory = .init()
        presenter = .init(
            repository: repository,
            router: router,
            taskFactory: taskFactory
        )
    }

    override func tearDown() {
        repository = nil
        router = nil
        taskFactory = nil
        presenter = nil
    }

    @MainActor func test_loadData_displayResultsWhenSuccess() async throws {
        presenter.loadData()
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 1)
        let task = try XCTUnwrap(taskFactory.tasks.first as? Task<Void, Never>)
        await task.value
        XCTAssertTrue(presenter.viewState.isSuccess)
    }

    @MainActor func test_loadData_displaysActionWhenNoResultsAvailable() async throws {
        await repository.set(viewModel: .init(items: []))
        presenter.loadData()
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 1)
        let task1 = try XCTUnwrap(taskFactory.tasks.first as? Task<Void, Never>)
        await task1.value
        let actionValue = try XCTUnwrap(presenter.viewState.actionValue)
        XCTAssertEqual(actionValue.title, "Whoops!")
        XCTAssertEqual(actionValue.actionTitle, "Try Again")
        XCTAssertEqual(actionValue.detail, "There is no data available at the moment")
        let viewModel = RaceListViewModel(items: [
            .init(id: "1", title: "title", detail: "detail", startTime: 100)
        ])
        await repository.set(viewModel: viewModel)
        actionValue.action()
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 2)
        let task2 = try XCTUnwrap(taskFactory.tasks.last as? Task<Void, Never>)
        await task2.value
        XCTAssertTrue(presenter.viewState.isSuccess)
    }

    @MainActor func test_loadData_displaysActionWhenErrorAppears() async throws {
        await repository.set(error: .networking)
        presenter.loadData()
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 1)
        let task1 = try XCTUnwrap(taskFactory.tasks.first as? Task<Void, Never>)
        await task1.value
        let actionValue = try XCTUnwrap(presenter.viewState.actionValue)
        XCTAssertEqual(actionValue.title, "Whoops!")
        XCTAssertEqual(actionValue.actionTitle, "Try Again")
        XCTAssertEqual(actionValue.detail, "An unexpected error found 🔧")
        await repository.set(error: nil)
        actionValue.action()
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 2)
        let task2 = try XCTUnwrap(taskFactory.tasks.last as? Task<Void, Never>)
        await task2.value
        XCTAssertTrue(presenter.viewState.isSuccess)
    }

    @MainActor func test_duplicatedLoadData_previousTasksWillBeCancelled() async throws {
        presenter.loadData()
        presenter.loadData()
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 2)
        let task1 = try XCTUnwrap(taskFactory.tasks.first as? Task<Void, Never>)
        XCTAssertTrue(task1.isCancelled)
        let task2 = try XCTUnwrap(taskFactory.tasks.last as? Task<Void, Never>)
        await task2.value
        XCTAssertTrue(presenter.viewState.isSuccess)
    }

    @MainActor func test_onFilter_callsRouter() {
        presenter.onFilter()
        XCTAssertEqual(router.routeToFilterCalls.count, 1)
        XCTAssertEqual(router.routeToFilterCalls[0].filter, .none)
        XCTAssertTrue(router.routeToFilterCalls[0].delegate === presenter)
    }

    @MainActor func test_viewDidLoad_loadsData() async throws {
        presenter.viewDidLoad()
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 1)
        let task = try XCTUnwrap(taskFactory.tasks.first as? Task<Void, Never>)
        await task.value
        XCTAssertTrue(presenter.viewState.isSuccess)
    }

    @MainActor func test_filterDidApply_whenFilterDidNotChange_doesNotLoadData() async throws {
        presenter.filterDidApply(filter: .none)
        XCTAssertTrue(presenter.viewState.isNotStarted)
    }

    @MainActor func test_filterDidApply_whenFilterChanged_loadsData() async throws {
        presenter.filterDidApply(filter: .greyhound)
        XCTAssertTrue(presenter.viewState.isLoading)
        XCTAssertEqual(taskFactory.tasks.count, 1)
        let task = try XCTUnwrap(taskFactory.tasks.first as? Task<Void, Never>)
        await task.value
        XCTAssertTrue(presenter.viewState.isSuccess)
    }

}

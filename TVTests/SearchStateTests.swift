//
//  SearchStateTests.swift
//  TVTests
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import XCTest
import ReSwift
@testable import TV

class SearchStateTests: XCTestCase, StoreSubscriber {
    typealias StoreSubscriberStateType = SearchState
    private var actualStates: [SearchState]?

    override func setUp() {
        let search = MockSearchProvider()
        let searchMiddleware = createMiddleware(items: searchService(with: search))

        actualStates = []

        store = Store<AppState>(
            reducer: appReducer,
            state: nil,
            middleware: [searchMiddleware]
        )

        store.subscribe(self) { $0.select { return $0.searchState } }
    }


    override func tearDown() {
        actualStates = nil
        store.unsubscribe(self)
    }

    func newState(state: SearchState) {
        actualStates?.append(state)
    }

    func testLoadSuccess() {
        let expectedStates = [
            SearchState(query: nil, items: nil, isLoading: false),
            SearchState(query: MockSearchProvider.MockQuery.success.rawValue, items: nil, isLoading: true),
            SearchState(query: MockSearchProvider.MockQuery.success.rawValue, items: MockSearchProvider.result, isLoading: false)
        ]
        store.dispatch(SearchAction.load(query: MockSearchProvider.MockQuery.success.rawValue))

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

    func testLoadFailure() {
        let expectedStates = [
            SearchState(query: nil, items: nil, isLoading: false),
            SearchState(query: MockSearchProvider.MockQuery.error.rawValue, items: nil, isLoading: true),
            SearchState(query: MockSearchProvider.MockQuery.error.rawValue, items: nil, isLoading: false)
        ]
        store.dispatch(SearchAction.load(query: MockSearchProvider.MockQuery.error.rawValue))

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

    func testCancel() {
        let expectedStates = [
            SearchState(query: nil, items: nil, isLoading: false),
            SearchState(query: MockSearchProvider.MockQuery.success.rawValue, items: nil, isLoading: true),
            SearchState(query: nil, items: nil, isLoading: false)
        ]
        store.dispatch(SearchAction.load(query: MockSearchProvider.MockQuery.success.rawValue))
        store.dispatch(SearchAction.cancel)

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

    func testFailure() {
        let expectedStates = [
            SearchState(query: nil, items: nil, isLoading: false)
        ]

        store.dispatch(SearchAction.failure(NSError()))

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

    func testIdle() {
        let expectedStates = [
            SearchState(query: nil, items: nil, isLoading: false)
        ]

        store.dispatch(SearchAction.idle)

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

}


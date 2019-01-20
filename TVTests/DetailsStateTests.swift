//
//  DetailsStateTests.swift
//  TVTests
//
//  Created by Oscar Sundin on 2019-01-20.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import XCTest
import ReSwift
@testable import TV

class DetailsStateTests: XCTestCase, StoreSubscriber {
    typealias StoreSubscriberStateType = DetailsState
    private var actualStates: [DetailsState]?

    override func setUp() {
        let details = MockDetailsProvider()
        let detailsMiddleware = createMiddleware(items: detailsService(with: details))

        actualStates = []

        store = Store<AppState>(
            reducer: appReducer,
            state: nil,
            middleware: [detailsMiddleware]
        )

        store.subscribe(self) { $0.select { return $0.detailsState } }
    }


    override func tearDown() {
        actualStates = nil
        store.unsubscribe(self)
    }

    func newState(state: DetailsState) {
        actualStates?.append(state)
    }

    func testLoadSuccess() {
        let expectedStates = [
            DetailsState(id: nil, item:nil, isLoading: false),
            DetailsState(id: MockDetailsProvider.MockQuery.success.rawValue, item: nil, isLoading: true),
            DetailsState(id: MockDetailsProvider.MockQuery.success.rawValue, item: MockDetailsProvider.result, isLoading: false)
        ]
        store.dispatch(DetailsAction.load(id: MockDetailsProvider.MockQuery.success.rawValue))

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

    func testLoadFailure() {
        let expectedStates = [
            DetailsState(id: nil, item:nil, isLoading: false),
            DetailsState(id: MockDetailsProvider.MockQuery.failure.rawValue, item: nil, isLoading: true),
            DetailsState(id: MockDetailsProvider.MockQuery.failure.rawValue, item: nil, isLoading: false)
        ]

        store.dispatch(DetailsAction.load(id: MockDetailsProvider.MockQuery.failure.rawValue))

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

    func testRetry() {
        let expectedStates = [
            DetailsState(id: nil, item:nil, isLoading: false),
            DetailsState(id: MockDetailsProvider.MockQuery.failure.rawValue, item: nil, isLoading: true),
            DetailsState(id: MockDetailsProvider.MockQuery.failure.rawValue, item: nil, isLoading: false)
        ]

        store.dispatch(DetailsAction.load(id: MockDetailsProvider.MockQuery.failure.rawValue))

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

    func testFailure() {
        let expectedStates = [
            DetailsState(id: nil, item:nil, isLoading: false)
        ]

        store.dispatch(DetailsAction.failure(NSError()))

        let result = XCTWaiter.wait(for: [XCTestExpectation(description: "Async request")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(actualStates == expectedStates, "Expected actualStates to match expectedStates")
        }
    }

}

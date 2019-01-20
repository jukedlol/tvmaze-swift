//
//  SearchProviderTests.swift
//  TVTests
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import XCTest
@testable import TV

class SearchProviderTests: XCTestCase {
    private var search: SearchProvider?
    
    override func tearDown() {
        search = nil
    }

    func testSuccess() {
        let expectation = XCTestExpectation(description: "Async request")
        search = MockSearchProvider()
        search?.load(withQuery: MockSearchProvider.MockQuery.success.rawValue, completion: {
            switch $0 {
            case .left:
                XCTAssert($0.isRight, "Expected result to be right")
            case .right(let result):
                XCTAssert(!result.isEmpty, "Expected result to be right and not empty")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testEmptySuccess() {
        let expectation = XCTestExpectation(description: "Async request")
        search = MockSearchProvider()
        search?.load(withQuery: MockSearchProvider.MockQuery.empty.rawValue, completion: {
            switch $0 {
            case .left:
                XCTAssert($0.isRight, "Expected result to be right")
            case .right(let result):
                XCTAssert(result.isEmpty, "Expected result to be right and empty")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testCancel() {
        let expectation = XCTestExpectation(description: "Async request")
        search = MockSearchProvider()
        search?.load(withQuery: MockSearchProvider.MockQuery.error.rawValue, completion: {
            switch $0 {
            case .left(let error):
                XCTAssert(error.isCancelled, "Expected result to be cancelled")
            case .right:
                XCTAssert($0.isLeft, "Expected result to be left")
            }
            expectation.fulfill()
        })
        search?.cancel()
        wait(for: [expectation], timeout: 0.5)
    }
    
    
    func testError() {
        let expectation = XCTestExpectation(description: "Async request")
        search = MockSearchProvider()
        search?.load(withQuery: MockSearchProvider.MockQuery.error.rawValue, completion: {
            XCTAssert($0.isLeft, "Expected result to be left")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
}


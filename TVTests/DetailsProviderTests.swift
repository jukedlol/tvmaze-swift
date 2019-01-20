//
//  DetailsProviderTests.swift
//  TVTests
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import XCTest
@testable import TV


class DetailsProviderTests: XCTestCase {
    private var provider: DetailsProvider?
    
    
    override func tearDown() {
        provider = nil
    }
    
    func testSuccess() {
        let expectation = XCTestExpectation(description: "Async request")
        provider = MockDetailsProvider()
        provider?.load(withId: MockDetailsProvider.MockQuery.success.rawValue, completion: {
            switch $0 {
            case .left:
                XCTAssert($0.isRight, "Expected result to be right")
            case .right(let result):
                XCTAssert(result == MockDetailsProvider.result, "Expected result to be right and match mock result")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    

    func testError() {
        let expectation = XCTestExpectation(description: "Async request")
        provider = MockDetailsProvider()
        provider?.load(withId: MockDetailsProvider.MockQuery.success.rawValue, completion: {
            XCTAssert($0.isRight, "Expected result to be left")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
}

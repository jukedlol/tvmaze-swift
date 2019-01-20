//
//  MockDetailsProvider.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Foundation

class MockDetailsProvider: DetailsProvider {

    static var result: DetailsItem = DetailsItem(id: 0, name: nil, genres: nil, image: nil, summary: nil)
    static var error: Error = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)

    enum MockQuery: Int {
        case success = 0
        case failure
    }

    func load(withId id: Int, completion: @escaping (DetailsResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: DispatchWorkItem {
                switch id {
                case MockQuery.success.rawValue:
                    completion(DetailsResult.right(MockDetailsProvider.result))
                default:
                    completion(DetailsResult.left(MockDetailsProvider.error))
                }
            })
    }

}

//
//  MockSearchProvider.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Either

class MockSearchProvider: SearchProvider {
    static var result: [SearchItem] = (0..<10).map { SearchItem(show: SearchItem.Show(id: $0, name: "Title \($0)", genres: nil, image: nil)) }
    static var emptyResult: [SearchItem] = []
    static var cancelledError: Error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil)
    static var error: Error = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)

    private var cancelled: Bool?

    enum MockQuery: String {
        case success
        case empty
        case error
    }

    func cancel() {
        cancelled = true
    }

    func load(withQuery query: String, completion: @escaping (SearchResult) -> Void) {
        cancelled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: DispatchWorkItem {
                switch (query, self.cancelled) {
                case (_, true):
                    completion(SearchResult.left(MockSearchProvider.cancelledError))
                case (MockQuery.success.rawValue, _):
                    completion(SearchResult.right(MockSearchProvider.result))
                case (MockQuery.empty.rawValue, _):
                    completion(SearchResult.right(MockSearchProvider.emptyResult))
                default:
                    completion(SearchResult.left(MockSearchProvider.error))
                }
            })
    }

}

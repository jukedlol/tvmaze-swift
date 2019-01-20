//
//  DefaultSearchProvider.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Foundation

class DefaultSearchProvider: SearchProvider {

    // MARK: - Properties

    private let session: URLSession
    private var task: URLSessionDataTask?

    // MARK: - Lifecycle

    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }

    // MARK: - Requests

    func cancel() {
        task?.cancel()
    }

    func load(withQuery query: String, completion: @escaping (SearchResult) -> Void) {
        var urlComponents = URLComponents(string: "https://api.tvmaze.com/search/shows")
        urlComponents?.queryItems = [URLQueryItem(name: "q", value: query)]

        guard let url = urlComponents?.url else {
            return
        }

        task = self.session.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            var result: SearchResult?
            defer {
                DispatchQueue.main.async {
                    completion(result ?? SearchResult.left(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)))
                }
            }

            if let error = error {
                result = SearchResult.left(error)
            } else if let data = data {
                do {
                    let items = try JSONDecoder().decode([SearchItem].self, from: data)
                    result = SearchResult.right(items)
                } catch {
                    result = SearchResult.left(error)
                }
            }
        }

        task?.resume()

    }

}

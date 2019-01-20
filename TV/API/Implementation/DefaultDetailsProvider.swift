//
//  DefaultDetailsProvider.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Foundation

class DefaultDetailsProvider: DetailsProvider {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Lifecycle

    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }

    func load(withId id: Int, completion: @escaping (DetailsResult) -> Void) {
        guard let url = URL(string: "https://api.tvmaze.com/shows/\(id)") else {
            return
        }
        self.session.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            var result: DetailsResult?
            defer {
                DispatchQueue.main.async {
                    completion(result ?? .left(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)))
                }
            }

            if let error = error {
                result = .left(error)
            } else if let data = data {
                do {
                    let item = try JSONDecoder().decode(DetailsItem.self, from: data)
                    result = .right(item)
                } catch {
                    result = .left(error)
                }
            }
        }.resume()

    }

}

//
//  SearchProvider.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Foundation
import Either

typealias SearchResult = Either<Error, [SearchItem]>

struct SearchItem: Codable, Equatable {
    struct Show: Codable, Equatable {
        struct Image: Codable, Equatable {
            let medium: String?
        }
        let id: Int
        let name: String?
        let genres: [String]?
        let image: Image?
    }
    let show: Show
}

protocol SearchProvider {
    func cancel()
    func load(withQuery query: String, completion: @escaping (SearchResult) -> Void)
}

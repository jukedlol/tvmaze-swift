//
//  DetailsProvider.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Either

typealias DetailsResult = Either<Error, DetailsItem>

struct DetailsItem: Codable, Equatable {
    struct Image: Codable, Equatable {
        let original: String?
    }
    let id: Int
    let name: String?
    let genres: [String]?
    let image: Image?
    let summary: String?
}

protocol DetailsProvider {
    func load(withId id: Int, completion: @escaping (DetailsResult) -> Void)
}

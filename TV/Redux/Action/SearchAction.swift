//
//  SearchAction.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

enum SearchAction: Action {
    case idle
    case cancel
    case load(query: String)
    case success([SearchItem])
    case failure(Error)
}

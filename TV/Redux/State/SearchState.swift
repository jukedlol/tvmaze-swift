//
//  SearchState.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

struct SearchState: StateType, Equatable {
    var query: String?
    var items: [SearchItem]?
    var isLoading: Bool
}

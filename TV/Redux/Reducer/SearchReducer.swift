//
//  SearchReducer.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

func searchReducer(action: Action, state: SearchState?) -> SearchState {
    var state = state ?? SearchState(query: nil, items: nil, isLoading: false)

    switch action {
    case let action as SearchAction:
        switch action {
        case .failure: //if the request fails, we still want to keep any existing items, don't set to nil
            state.isLoading = false
        case .success(let items):
            state.isLoading = false
            state.items = items.filter { $0.show.name != nil || $0.show.image?.medium != nil }
        case .load(let query):
            state.query = query
            state.isLoading = true
        case .idle:
            state.query = nil
            state.isLoading = false
            state.items = nil
        case .cancel:
            state.query = nil
            state.isLoading = false
        }
    default:
        return state
    }

    return state
}

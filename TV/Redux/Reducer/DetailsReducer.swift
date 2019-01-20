//
//  DetailsReducer.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

func detailsReducer(action: Action, state: DetailsState?) -> DetailsState {
    var state = state ?? DetailsState(id: nil, item: nil, isLoading: false)

    switch action {
    case let action as DetailsAction:
        switch action {
        case .failure:
            state.item = nil
            state.isLoading = false
        case .success(let item):
            state.isLoading = false
            state.item = item
        case .load(let id):
            state.item = nil
            state.id = id
            state.isLoading = true
        default: break
        }
    default:
        return state
    }

    return state
}

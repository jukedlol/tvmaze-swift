//
//  AppReducer.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        searchState: searchReducer(action: action, state: state?.searchState),
        detailsState: detailsReducer(action: action, state: state?.detailsState)
    )
}

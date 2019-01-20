//
//  DetailsMiddleware.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

func detailsService(with provider: DetailsProvider) -> [MiddlewareItem] {
    return injectService(service: provider, receivers: [details])
}

func details(provider: DetailsProvider) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction, getState: GetStateFunction) in
        guard let action = action as? DetailsAction else {
            return
        }

        switch action {
        case .load(let id):
            provider.load(withId: id) {
                dispatch($0.either(ifLeft: DetailsAction.failure, ifRight: DetailsAction.success))
            }
        case .retry:
            getState()?.detailsState.id.map(DetailsAction.load).map(dispatch)
        default: break
        }
    }

}

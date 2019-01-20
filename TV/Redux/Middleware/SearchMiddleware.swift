//
//  SearchMiddleware.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

func searchService(with provider: SearchProvider) -> [MiddlewareItem] {
    return injectService(service: provider, receivers: [search])
}

func search(provider: SearchProvider) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction, getState: GetStateFunction) in
        guard let action = action as? SearchAction else {
            return
        }

        switch action {
        case .load(let query):
            provider.cancel()
            provider.load(withQuery: query) {
                dispatch($0.either(ifLeft: {
                    $0.isCancelled ? SearchAction.cancel : SearchAction.failure($0)
                }, ifRight: SearchAction.success))
            }
        case .idle:
            provider.cancel()
        case .cancel:
            provider.cancel()
        default: break
        }
    }

}

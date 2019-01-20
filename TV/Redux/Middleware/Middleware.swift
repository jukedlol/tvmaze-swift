//
//  Middleware.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

typealias GetStateFunction = () -> AppState?
typealias MiddlewareItem = (Action, @escaping DispatchFunction, @escaping GetStateFunction) -> Void

func createMiddleware(items: [MiddlewareItem]) -> Middleware<AppState> {
    return { dispatch, getState in
        return { next in
            return { action in
                items.forEach { $0(action, dispatch, getState) }
                return next(action)
            }
        }
    }
}

func injectService<T, U>(service: T, receivers: [(T) -> (U)]) -> [U] {
    return receivers.map { $0(service) }
}

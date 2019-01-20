//
//  DetailsAction.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

enum DetailsAction: Action {
    case load(id: Int)
    case success(DetailsItem)
    case failure(Error)
    case retry
}

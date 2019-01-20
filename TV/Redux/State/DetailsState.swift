//
//  DetailsState.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

struct DetailsState: StateType, Equatable {
    var id: Int?
    var item: DetailsItem?
    var isLoading: Bool
}

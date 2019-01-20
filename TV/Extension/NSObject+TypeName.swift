//
//  NSObject+TypeName.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Foundation

protocol TypeIdentifiable {
    static var typeName: String { get }
    var typeName: String { get }
}

extension TypeIdentifiable {
    static var typeName: String { return String(describing: self) }
    var typeName: String { return String(describing: type(of:self)) }
}

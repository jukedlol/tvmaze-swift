//
//  UIImageView+URL.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Nuke

extension UIImageView {

    func load(imageUrl: String) {
        var urlComponents = URLComponents(string: imageUrl)
        urlComponents?.scheme = "https"

        guard let url = urlComponents?.url else {
            return
        }

        Nuke.loadImage(with: url, into: self)
    }

}

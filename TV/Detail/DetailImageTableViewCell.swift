//
//  DetailImageTableViewCell.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell, TypeIdentifiable {

    // MARK: - Model

    struct Model: Equatable {
        let imageUrl: String?

        init(item: DetailsItem) {
            self.imageUrl = item.image?.original
        }
    }

    // MARK: - Outlets

    @IBOutlet private var showImageView: UIImageView!

    // MARK: - View

    override func prepareForReuse() {
        super.prepareForReuse()
        showImageView.image = nil
    }

    // MARK: - API

    func set(model: Model) {
        model.imageUrl.map(showImageView.load)
    }

}

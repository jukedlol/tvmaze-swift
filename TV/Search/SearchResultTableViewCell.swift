//
//  SearchResultTableViewCell.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell, TypeIdentifiable {

    // MARK: - Model

    struct Model {
        let imageUrl: String?
        let genres: String?
        let title: String?

        init(item: SearchItem) {
            imageUrl = item.show.image?.medium
            genres = item.show.genres?.joined(separator: ", ")
            title = item.show.name
        }
    }

    // MARK: - Properties

    @IBOutlet private(set) var showImageView: UIImageView!
    @IBOutlet private(set) var showTitleLabel: UILabel!
    @IBOutlet private(set) var showGenresLabel: UILabel!

    // MARK: - View

    override func prepareForReuse() {
        super.prepareForReuse()
        showImageView.image = nil
        showTitleLabel.text = nil
        showGenresLabel.text = nil
    }

    // MARK: - API

    func set(model: Model) {
        model.imageUrl.map(showImageView.load)
        showTitleLabel.text = model.title
        showGenresLabel.text = model.genres
    }

}

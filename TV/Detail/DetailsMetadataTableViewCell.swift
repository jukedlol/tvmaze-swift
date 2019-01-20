//
//  DetailsMetadataTableViewCell.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit

class DetailsMetadataTableViewCell: UITableViewCell, TypeIdentifiable {

    // MARK: - Model

    struct Model: Equatable {
        let title: String?
        let genres: String?
        let description: NSAttributedString?

        init(item: DetailsItem) {
            self.title = item.name
            self.genres = item.genres?.joined(separator: ",")
            self.description =  item.summary?.data(using: .unicode).map {
                try? NSAttributedString(data: $0, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            }?.map { $0 }
        }
    }

    // MARK: - Properties

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var genresLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    //MARK: - View

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        genresLabel.text = nil
        descriptionLabel.attributedText = nil
    }

    //MARK: - API
    
    func set(model: Model) {
        titleLabel.text = model.title
        genresLabel.text = model.genres
        descriptionLabel.attributedText = model.description
    }

}

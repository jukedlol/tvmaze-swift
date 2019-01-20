//
//  DetailsResultViewController.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit

class DetailsResultViewController: UIViewController, TypeIdentifiable {

    // MARK: - Model

    struct Model: Equatable {
        enum Section: Equatable {
            case image(DetailImageTableViewCell.Model)
            case metadata(DetailsMetadataTableViewCell.Model)

            static func == (lhs: Section, rhs: Section) -> Bool {
                switch (lhs, rhs) {
                case (.image(let lhsModel), .image(let rhsModel)):
                    return lhsModel == rhsModel
                case (.metadata(let lhsModel), .metadata(let rhsModel)):
                    return lhsModel == rhsModel
                default:
                    return false
                }
            }

        }

        let sections: [Section]

        init(item: DetailsItem) {
            let imageSection = DetailImageTableViewCell.Model(item: item)
            let metadataSection = DetailsMetadataTableViewCell.Model(item: item)
            let sections: [DetailsResultViewController.Model.Section] = [.image(imageSection), .metadata(metadataSection)]
            self.sections = sections
        }
        
    }

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: DetailImageTableViewCell.typeName, bundle: Bundle.main), forCellReuseIdentifier: DetailImageTableViewCell.typeName)
            tableView.register(UINib(nibName: DetailsMetadataTableViewCell.typeName, bundle: Bundle.main), forCellReuseIdentifier: DetailsMetadataTableViewCell.typeName)
        }
    }

    // MARK: - Properties

    private var model: Model?

    // MARK: - Lifecycle

    static func make() -> DetailsResultViewController {
        let storyboard = UIStoryboard(name: DetailsResultViewController.typeName, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! DetailsResultViewController
        return viewController
    }

    // MARK: - API

    func set(model: Model) {
        let oldModel = self.model
        if model != oldModel {
            self.model = model
            tableView.reloadData()
        }
    }

}

extension DetailsResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model?.sections[indexPath.row] {
        case .image(let model)?:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageTableViewCell.typeName, for: indexPath) as! DetailImageTableViewCell
            cell.set(model: model)
            return cell
        case .metadata(let model)?:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsMetadataTableViewCell.typeName, for: indexPath) as! DetailsMetadataTableViewCell
            cell.set(model: model)
            return cell
        default:
            fatalError()
        }
    }

}

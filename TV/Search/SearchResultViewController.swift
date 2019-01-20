//
//  SearchResultViewController.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, TypeIdentifiable {

    // MARK: - Model

    struct Model: Equatable {
        let items: [SearchItem]

        init(state: SearchState) {
            items = state.items ?? []
        }
    }

    // MARK: - Outlets

    @IBOutlet private(set) var tableView: UITableView! {
        didSet {
            tableView.register(
                UINib(nibName: SearchResultTableViewCell.typeName, bundle: Bundle.main),
                forCellReuseIdentifier: SearchResultTableViewCell.typeName
            )
        }
    }

    // MARK: - Properties

    private var model: Model?
    private var modalNavigationController: UINavigationController?

    // MARK: - Lifecycle

    static func make() -> SearchResultViewController {
        let storyboard = UIStoryboard(name: SearchResultViewController.typeName, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! SearchResultViewController
        return viewController
    }

    // MARK: - API

    func set(model: Model) {
        let oldModel = self.model

        if model != oldModel {
            self.model = model
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    @objc private func dismissModal() {
        modalNavigationController?.dismiss(animated: true, completion: nil)
    }

}

// MARK: - UITableViewDelegate

extension SearchResultViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = model?.items[indexPath.row].show else {
            return
        }

        let viewController = DetailsViewController.make(with: DetailsViewController.Model(id: item.id))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModal))
        viewController.navigationItem.rightBarButtonItem = doneButton
        viewController.title = item.name
        modalNavigationController = UINavigationController(rootViewController: viewController)
        modalNavigationController.map { self.present($0, animated: true, completion: nil) }
    }

}

// MARK: - UITableViewDataSource

extension SearchResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model?.items[indexPath.row] else {
            fatalError()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.typeName, for: indexPath) as! SearchResultTableViewCell

        cell.set(model: SearchResultTableViewCell.Model(item: item))

        return cell
    }

}

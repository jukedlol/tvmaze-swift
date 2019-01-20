//
//  SearchViewController.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit
import ReSwift

class SearchViewController: UIViewController {

    // MARK: - Properties

    private lazy var searchInputViewController = SearchInputViewController.make()
    private lazy var searchResultViewController = SearchResultViewController.make()

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        applyConstraints()

        subscribe()
    }

    /*
     Using child view controllers to render the UI.
     This allows me to easily switch out search results with a search history, empty result view etc.
     */
    private func addSubviews() {
        addChild(searchResultViewController)
        view.addSubview(searchResultViewController.view)
        searchResultViewController.didMove(toParent: self)

        addChild(searchInputViewController)
        view.addSubview(searchInputViewController.view)
        searchInputViewController.didMove(toParent: self)
    }

    private func applyConstraints() {
        searchInputViewController.view.translatesAutoresizingMaskIntoConstraints = false
        searchInputViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchInputViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchInputViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchInputViewController.view.heightAnchor.constraint(equalToConstant: 64).isActive = true

        searchResultViewController.view.translatesAutoresizingMaskIntoConstraints = false
        searchResultViewController.view.topAnchor.constraint(equalTo: searchInputViewController.view.bottomAnchor).isActive = true
        searchResultViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchResultViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchResultViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}

// MARK: - StoreSubscriber

extension SearchViewController: StoreSubscriber {

    typealias StoreSubscriberStateType = SearchState

    func subscribe() {
        store.subscribe(self) { $0.select { return $0.searchState } }
    }

    func newState(state: SearchState) {
        searchInputViewController.set(model: SearchInputViewController.Model(state: state))
        searchResultViewController.set(model: SearchResultViewController.Model(state: state))
    }

}

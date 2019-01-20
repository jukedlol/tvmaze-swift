//
//  SearchInputViewController.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit

class SearchInputViewController: UIViewController, TypeIdentifiable, UISearchBarDelegate {

    // MARK: - Model

    struct Model: Equatable {
        let loading: Bool

        init(state: SearchState) {
            loading = state.isLoading
        }
    }

    // MARK: - Outlets

    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private var textField: UITextField! {
        didSet {
            textField.rightView = loadingIndicator
        }
    }

    // MARK: - Properties

    private lazy var throttler = Throttler(interval: 0.10)
    private var model: Model?

    // MARK: - Lifecycle

    static func make() -> SearchInputViewController {
        let storyboard = UIStoryboard(name: SearchInputViewController.typeName, bundle: Bundle.main)
        return storyboard.instantiateInitialViewController() as! SearchInputViewController
    }

    // MARK: - API

    func set(model: Model) {
        let oldModel = self.model
        if model != oldModel {
            self.model = model

            if model.loading {
                textField.rightViewMode = .always
                loadingIndicator.startAnimating()
            } else {
                textField.rightViewMode = .never
                loadingIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Text field Selector

    @IBAction func textFieldPrimaryAction(_ sender: UITextField) {
        if let query = sender.text, query.isEmpty == false {
            store.dispatch(SearchAction.load(query: query))
        } else {
            store.dispatch(SearchAction.idle)
        }
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        /*
         Throttling the search query.
         Reduces amount of requests sent to the API, irrelevant responses & UI updates.
        */
        throttler.call {
            if let query = sender.text, query.isEmpty == false {
                store.dispatch(SearchAction.load(query: query))
            } else {
                store.dispatch(SearchAction.idle)
            }
        }
    }

}

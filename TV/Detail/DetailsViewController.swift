//
//  DetailsViewController.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit
import ReSwift

class DetailsViewController: UIViewController, TypeIdentifiable {

    // MARK: - Model

    struct Model: Equatable {
        let id: Int
    }


    // MARK: - Outlets

    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Properties

    private var model: Model?
    private var resultViewController: DetailsResultViewController?
    private var errorViewController: DetailsErrorViewController?

    // MARK: - Lifecycle

    static func make(with model: Model) -> DetailsViewController {
        let storyboard = UIStoryboard(name: DetailsViewController.typeName, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! DetailsViewController
        viewController.set(model: model)
        return viewController
    }

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }

    /*
     Using child view controllers to render the UI.
     This allows me to easily toggle between success/failure/loading states.
     */

    private func add(contentViewController: UIViewController) {
        addChild(contentViewController)
        view.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)

        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        contentViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func remove(contentViewController: UIViewController) {
        contentViewController.removeFromParent()
        contentViewController.view.removeFromSuperview()
    }

    // MARK: - API

    func set(model: Model) {
        store.dispatch(DetailsAction.load(id: model.id))
    }

}

// MARK: - StoreSubscriber

extension DetailsViewController: StoreSubscriber {

    typealias StoreSubscriberStateType = DetailsState

    func subscribe() {
        store.subscribe(self) { $0.select { return $0.detailsState } }
    }

    func newState(state: DetailsState) {
        switch (state.item, state.isLoading) {

        case (let item?, _):
            loadingIndicator.stopAnimating()

            errorViewController.map(remove)

            resultViewController = DetailsResultViewController.make()
            resultViewController.map(add)

            resultViewController?.set(model: DetailsResultViewController.Model(item: item))
        case (nil, false):
            loadingIndicator.stopAnimating()

            resultViewController.map(remove)

            errorViewController = DetailsErrorViewController.make()
            errorViewController.map(add)
        default:
            loadingIndicator.startAnimating()
        }

    }

}

//
//  DetailsErrorViewController.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-19.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import UIKit

class DetailsErrorViewController: UIViewController, TypeIdentifiable {

    // MARK: - Lifecycle

    static func make() -> DetailsErrorViewController {
        let storyboard = UIStoryboard(name: DetailsErrorViewController.typeName, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! DetailsErrorViewController
        return viewController
    }

    // MARK: - Selector

    @IBAction private func retryPrimaryAction() {
        store.dispatch(DetailsAction.retry)
    }

}

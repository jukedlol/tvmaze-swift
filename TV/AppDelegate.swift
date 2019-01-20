//
//  AppDelegate.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        /*Injecting providers.
        Started out by mocking the data, using mocked providers, without having looked into the API schema.
        In a real world example, this would allow work on the feature without relying on the API to be feature complete.
         */
        let search = DefaultSearchProvider()
        let searchMiddleware = createMiddleware(items: searchService(with: search))

        let details = DefaultDetailsProvider()
        let detailsMiddleware = createMiddleware(items: detailsService(with: details))

        /*
        The strict pattern reduces the chance of inconsistencies being introduced in the applications architecture.

        If I where to develop this application further.
        I would look into implementing the use of time traveling for search results & search history, so ReSwift fits the purpose of the application well.
         */
        store = Store<AppState>(
            reducer: appReducer,
            state: nil,
            middleware: [searchMiddleware, detailsMiddleware]
        )

        return true
    }

}

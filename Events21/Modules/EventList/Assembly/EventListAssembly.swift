//
//  EventListAssembly.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

enum EventListAssembly {
    // MARK: Static methods
	static func createModule(me: UserFullModel) -> UIViewController {
        let viewController = EventListView()
        let router = EventListRouter(view: viewController)
		let intraAPIService = IntraAPIService.shared
        let filterStorage = FiltersStorage.shared
        let interactor = EventListInteractor(
			intraAPIService: intraAPIService,
			filterStorage: filterStorage
		)
        let dataSource = EventListDataSource()
        let presenter = EventListPresenter(
			view: viewController,
            interactor: interactor,
            router: router,
            dataSource: dataSource,
			me: me
		)

        viewController.presenter = presenter
        dataSource.presenter = presenter

        return viewController
    }
}

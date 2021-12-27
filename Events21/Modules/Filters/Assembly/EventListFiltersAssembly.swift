//
//  EventListFiltersAssembly.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit

enum EventListFiltersAssembly{
    
    // MARK: Static methods
    static func createModule(delegate: TableViewToFiltersDelegateProtocol) -> UIViewController {

        let viewController = EventListFiltersView()
        let router = EventListFiltersRouter(view: viewController)
        let interactor = EventListFiltersInteractor()
        let dataSource = EventListFiltersDataSource()
        let presenter = EventListFiltersPresenter(view: viewController,
                                         interactor: interactor,
                                         router: router,
                                         dataSource: dataSource,
                                         delegate: delegate)

        viewController.presenter = presenter
        dataSource.presenter = presenter

        return viewController
    }
}

//
//  FiltersAssembly.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit

enum FiltersAssembly{
    
    // MARK: Static methods
    static func createModule(delegate: TableViewToFiltersDelegateProtocol) -> UIViewController {

        let viewController = FiltersViewController()
        let router = FiltersRouter(view: viewController)
        let interactor = FiltersInteractor()
        let dataSource = FiltersPresenterDataSource()
        let presenter = FiltersPresenter(view: viewController,
                                         interactor: interactor,
                                         router: router,
                                         dataSource: dataSource,
                                         delegate: delegate)

        viewController.presenter = presenter
        dataSource.presenter = presenter

        return viewController
    }
}

//
//  EventAssembly.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

enum EventAssembly{
    
    // MARK: Static methods
    static func createModule() -> UIViewController {

        let viewController = EventViewController()
        let router = EventRouter(view: viewController)
        let interactor = EventInteractor()
        let dataSource = EventPresenterDataSource()
        let presenter = EventPresenter(view: viewController, interactor: interactor, router: router, dataSource: dataSource)

        viewController.presenter = presenter
        dataSource.presenter = presenter

        return viewController
    }
}

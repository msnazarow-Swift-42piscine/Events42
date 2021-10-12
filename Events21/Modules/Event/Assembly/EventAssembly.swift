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
    static func createModule(with model: EventCellModel, userId: Int) -> UIViewController {

        let viewController = EventViewController()
        let router = EventRouter(view: viewController)
        let intraAPIService = IntraAPIService.shared
        let interactor = EventInteractor(intraAPIService: intraAPIService)
        let dataSource = EventPresenterDataSource()
        let presenter = EventPresenter(view: viewController,
                                       interactor: interactor,
                                       router: router,
                                       dataSource: dataSource,
                                       model: model,
                                       userId: userId)

        viewController.presenter = presenter
        dataSource.presenter = presenter

        return viewController
    }
}

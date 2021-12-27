//
//  EventDetailAssembly.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

enum EventDetailAssembly{
    
    // MARK: Static methods
    static func createModule(with model: EventResponse, userId: Int) -> UIViewController {

        let viewController = EventDetailView()
        let router = EventDetailRouter(view: viewController)
        let intraAPIService = IntraAPIService.shared
        let interactor = EventDetailInteractor(intraAPIService: intraAPIService)
        let dataSource = EventDetailDataSource()
        let presenter = EventDetailPresenter(view: viewController,
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

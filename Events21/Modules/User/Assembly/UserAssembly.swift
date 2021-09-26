//
//  UserAssembly.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

enum UserAssembly{
    
    // MARK: Static methods
    static func createModule() -> UIViewController {

        let viewController = UserViewController()
        let router = UserRouter(view: viewController)
        let intraAPIService = IntraAPIService.shared
        let imageCashingService = ImageCashingService()
        let interactor = UserInteractor(intraAPIService: intraAPIService, imageCashingService: imageCashingService)
        let dataSource = UserPresenterDataSource()
        let presenter = UserPresenter(view: viewController, interactor: interactor, router: router, dataSource: dataSource)

        viewController.presenter = presenter
        dataSource.presenter = presenter

        return viewController
    }
}

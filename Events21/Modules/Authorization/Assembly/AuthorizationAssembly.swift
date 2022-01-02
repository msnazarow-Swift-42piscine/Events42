//
//  AuthorizationAssembly.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit

enum AuthorizationAssembly {
    // MARK: Static methods
    static func createModule() -> UIViewController {
        let viewController = AuthorizationViewController()
        let router = AuthorizationRouter(view: viewController)
//        #if DEBUG
//            let intraAPIService = IntraAPIServiceMock()
//        #else
            let intraAPIService = IntraAPIService.shared
//        #endif
        let interactor = AuthorizationInteractor(intraAPIService: intraAPIService)
        let dataSource = AuthorizationDataSource()
        let presenter = AuthorizationPresenter(
			view: viewController,
			interactor: interactor,
			router: router,
			dataSource: dataSource
		)

        viewController.presenter = presenter
        dataSource.presenter = presenter

        return viewController
    }
}

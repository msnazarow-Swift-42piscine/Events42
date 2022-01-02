//
//  SearchUserAssembly.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//  
//

import UIKit

enum SearchUserAssembly{
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        let router = SearchUserRouter()
		let intraAPIService = IntraAPIService.shared
        let interactor = SearchUserInteractor(intraAPIservice: intraAPIService)
        let dataSource = SearchUserDataSource()
        let presenter = SearchUserPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource
        )
        let view = SearchUserViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

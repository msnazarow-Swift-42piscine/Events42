//
//  ProjectsAssembly.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

enum ProjectsAssembly{
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        let router = ProjectsRouter()
        let interactor = ProjectsInteractor()
        let dataSource = ProjectsPresenterDataSource()
        let presenter = ProjectsPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource
        )
        let view = ProjectsViewController(presenter: ViewToPresenterProjectsProtocol)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

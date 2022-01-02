//
//  ProjectsAssembly.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

enum ProjectsAssembly {
    // MARK: Static methods
	static func createModule(projects: [ProjectUser]) -> UIViewController {
        let router = ProjectsRouter()
        let interactor = ProjectsInteractor()
        let dataSource = ProjectsDataSource()
        let presenter = ProjectsPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource,
			projects: projects
        )
        let view = ProjectsViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

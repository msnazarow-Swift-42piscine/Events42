//
//  ProjectsPresenter.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import Foundation

class ProjectsPresenter: ViewToPresenterProjectsProtocol {
    // MARK: Properties
    weak var view: PresenterToViewProjectsProtocol?
    let interactor: PresenterToInteractorProjectsProtocol
    let router: PresenterToRouterProjectsProtocol
    let dataSource: PresenterToDataSourceProjectsProtocol
	let projects: [ProjectUser]

    // MARK: Init
    init(
        interactor: PresenterToInteractorProjectsProtocol,
        router: PresenterToRouterProjectsProtocol,
        dataSource: PresenterToDataSourceProjectsProtocol,
		projects: [ProjectUser]
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
		self.projects = projects
    }

    func viewDidLoad() {
		dataSource.updateForSections([ProjectsSectionModel(projects)])
    }
}

extension ProjectsPresenter: CellToPresenterProjectsProtocol {
}

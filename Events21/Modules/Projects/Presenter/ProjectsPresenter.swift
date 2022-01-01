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
    let dataSource:PresenterToDataSourceProjectsProtocol

    // MARK: Init
    init(
        interactor: PresenterToInteractorProjectsProtocol,
        router: PresenterToRouterProjectsProtocol,
        dataSource: PresenterToDataSourceProjectsProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){

    }
}

extension ProjectsPresenter: CellToPresenterProjectsProtocol {
    
}

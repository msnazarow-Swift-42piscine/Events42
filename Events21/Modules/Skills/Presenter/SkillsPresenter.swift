//
//  SkillsPresenter.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import Foundation

class SkillsPresenter: ViewToPresenterSkillsProtocol {

    // MARK: Properties
    weak var view: PresenterToViewSkillsProtocol?
    let interactor: PresenterToInteractorSkillsProtocol
    let router: PresenterToRouterSkillsProtocol
    let dataSource:PresenterToDataSourceSkillsProtocol

    // MARK: Init
    init(
        interactor: PresenterToInteractorSkillsProtocol,
        router: PresenterToRouterSkillsProtocol,
        dataSource: PresenterToDataSourceSkillsProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){

    }
}

extension SkillsPresenter: CellToPresenterSkillsProtocol {
    
}

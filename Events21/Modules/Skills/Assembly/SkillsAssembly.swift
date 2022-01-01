//
//  SkillsAssembly.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

enum SkillsAssembly{
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        let router = SkillsRouter()
        let interactor = SkillsInteractor()
        let dataSource = SkillsPresenterDataSource()
        let presenter = SkillsPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource
        )
        let view = SkillsViewController(presenter: ViewToPresenterSkillsProtocol)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

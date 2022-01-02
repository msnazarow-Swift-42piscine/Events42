//
//  SkillsAssembly.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

enum SkillsAssembly {
    // MARK: Static methods
	static func createModule(skills: [SkillModel]) -> UIViewController {
        let router = SkillsRouter()
        let interactor = SkillsInteractor()
        let dataSource = SkillsDataSource()
        let presenter = SkillsPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource,
			skills: skills
        )
        let view = SkillsViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

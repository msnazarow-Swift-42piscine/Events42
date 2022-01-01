//
//  AchievementsAssembly.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

enum AchievementsAssembly{
    
    // MARK: Static methods
	static func createModule(achievements: [AchievementResponse]) -> UIViewController {
        let router = AchievementsRouter()
        let interactor = AchievementsInteractor()
        let dataSource = AchievementsDataSource()
        let presenter = AchievementsPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource,
			achievements: achievements
        )
        let view = AchievementsViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

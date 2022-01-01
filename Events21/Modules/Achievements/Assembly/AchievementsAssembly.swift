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
    static func createModule() -> UIViewController {
        let router = AchievementsRouter()
        let interactor = AchievementsInteractor()
        let dataSource = AchievementsPresenterDataSource()
        let presenter = AchievementsPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource
        )
        let view = AchievementsViewController(presenter: ViewToPresenterAchievementsProtocol)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

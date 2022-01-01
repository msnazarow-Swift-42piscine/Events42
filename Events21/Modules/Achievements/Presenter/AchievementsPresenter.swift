//
//  AchievementsPresenter.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import Foundation

class AchievementsPresenter: ViewToPresenterAchievementsProtocol {

    // MARK: Properties
    weak var view: PresenterToViewAchievementsProtocol?
    let interactor: PresenterToInteractorAchievementsProtocol
    let router: PresenterToRouterAchievementsProtocol
    let dataSource:PresenterToDataSourceAchievementsProtocol

    // MARK: Init
    init(
        interactor: PresenterToInteractorAchievementsProtocol,
        router: PresenterToRouterAchievementsProtocol,
        dataSource: PresenterToDataSourceAchievementsProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){

    }
}

extension AchievementsPresenter: CellToPresenterAchievementsProtocol {
    
}

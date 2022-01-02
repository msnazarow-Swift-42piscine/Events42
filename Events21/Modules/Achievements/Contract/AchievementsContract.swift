//
//  AchievementsContract.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewAchievementsProtocol: AnyObject {
	func tableViewReload()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAchievementsProtocol: AnyObject {
    var dataSource:PresenterToDataSourceAchievementsProtocol { get }

    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAchievementsProtocol: AnyObject {

}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterAchievementsProtocol: AnyObject {
    
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceAchievementsProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [TableViewSectionProtocol])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterAchievementsProtocol: AnyObject {

}

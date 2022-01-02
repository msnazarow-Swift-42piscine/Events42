//
//  SkillsContract.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSkillsProtocol: AnyObject {
	func tableViewReload()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSkillsProtocol: AnyObject {
    var dataSource: PresenterToDataSourceSkillsProtocol { get }

    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSkillsProtocol: AnyObject {
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterSkillsProtocol: AnyObject {
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceSkillsProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [TableViewSectionProtocol])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterSkillsProtocol: AnyObject {
}

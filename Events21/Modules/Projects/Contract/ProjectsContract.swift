//
//  ProjectsContract.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewProjectsProtocol: AnyObject {
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterProjectsProtocol: AnyObject {
    var dataSource: PresenterToDataSourceProjectsProtocol { get }

    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProjectsProtocol: AnyObject {
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterProjectsProtocol: AnyObject {
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceProjectsProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [TableViewSectionProtocol])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterProjectsProtocol: AnyObject {
}

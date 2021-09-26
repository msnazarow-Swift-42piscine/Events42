//
//  EventContract.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewEventProtocol: AnyObject {

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterEventProtocol: AnyObject {
    var dataSource:PresenterToDataSourceEventProtocol { get }
    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorEventProtocol: AnyObject {

}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterEventProtocol: AnyObject {
    
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceEventProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [SectionModel])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterEventProtocol: AnyObject {

}

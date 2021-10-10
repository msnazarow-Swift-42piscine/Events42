//
//  FiltersContract.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit
import OrderedCollections

// MARK: View Output (Presenter -> View)
protocol PresenterToViewFiltersProtocol: AnyObject {

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterFiltersProtocol: AnyObject {
    var dataSource:PresenterToDataSourceFiltersProtocol { get }
    func viewDidLoad()
    func viewWillAppear()
    func viewDidDisappear()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorFiltersProtocol: AnyObject {
    func saveFilters(filters: OrderedDictionary<String, Bool>)
    func loadFilters() -> OrderedDictionary<String, Bool>?
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterFiltersProtocol: AnyObject {
    
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceFiltersProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [FilterSectionModel])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterFiltersProtocol: AnyObject {
    func switcherDidChanged(_ title: String)
}

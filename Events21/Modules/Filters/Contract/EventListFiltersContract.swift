//
//  EventListFiltersContract.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit
import OrderedCollections

// MARK: View Output (Presenter -> View)
protocol PresenterToViewFiltersProtocol: AnyObject {
    var pickerView: ToolbarPickerView { get }

    func updateSortItem(_ number: Int)
    func insertRow(at indexPath: IndexPath)
    func removeRows(after indexPath: IndexPath, number: Int)
    func selectPicker(at row: Int)
    func reloadPickerView()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterFiltersProtocol: AnyObject {
    var dataSource: PresenterToDataSourceFiltersProtocol { get }

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
protocol PresenterToDataSourceFiltersProtocol: UITableViewDataSource,
	UIPickerViewDataSource,
	UIPickerViewDelegate,
	ToolbarPickerViewDelegate {
    func appendSortSelect(_ strings: [String?])
//    func addLabelToPickerView( _title: String)
    func updateForSections(_ sections: [TableViewSectionProtocol])
    func removeTemporarySortSelect()
    func addTemporarySortSelect(_ string: String)
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterFiltersProtocol: AnyObject {
    var dataSource: PresenterToDataSourceFiltersProtocol { get }

    func switcherDidChanged(_ title: String)
    func textFieldDidBeginEditing(_ number: Int)
    func setTextField(_ text: String)
    func textFieldResignFirstResponder()
    func selectPicker(at row: Int)
}

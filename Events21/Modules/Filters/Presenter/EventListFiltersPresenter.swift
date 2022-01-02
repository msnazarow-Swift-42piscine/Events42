//
//  EventListFiltersPresenter.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import Foundation
import OrderedCollections

class EventListFiltersPresenter: ViewToPresenterFiltersProtocol {
    // MARK: Properties
    weak var view: PresenterToViewFiltersProtocol!
    let interactor: PresenterToInteractorFiltersProtocol
    let router: PresenterToRouterFiltersProtocol
    let dataSource: PresenterToDataSourceFiltersProtocol
    weak var delegate: TableViewToFiltersDelegateProtocol?
    var filters: OrderedDictionary<String, Bool> = [
		.myCursus: false,
		.myCampus: false,
		.future: false,
		.didSubscribe: false
    ]
    var sort: [String?] = [.none]

    var editingNubmer: Int!
    // MARK: Init
    init(
		view: PresenterToViewFiltersProtocol,
		interactor: PresenterToInteractorFiltersProtocol,
		router: PresenterToRouterFiltersProtocol,
		dataSource: PresenterToDataSourceFiltersProtocol,
		delegate: TableViewToFiltersDelegateProtocol
	) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
        self.delegate = delegate
    }

    func viewDidLoad() {
    }

    func viewWillAppear() {
        if let filters = interactor.loadFilters() {
            self.filters = filters
        }

        dataSource.updateForSections([
            FilterSectionModel(filters.map { FilterModel(name: $0.key, value: $0.value) }),
            SortSectionModel(sort.enumerated().map { SortModel(sortName: $0.element, isActive: $0.offset == 0, number: $0.offset, inputView: view.pickerView) })
        ])
    }

    func viewDidDisappear() {
        delegate?.refresh(filters: filters, sort: sort)
        interactor.saveFilters(filters: filters)
    }
}

extension EventListFiltersPresenter: CellToPresenterFiltersProtocol {
    func switcherDidChanged(_ title: String) {
        filters[title]?.toggle()
    }

    func textFieldDidBeginEditing(_ number: Int) {
        editingNubmer = number
        dataSource.removeTemporarySortSelect()
        view.selectPicker(at: 0)
        if var sortName = sort[editingNubmer], !sortName.isEmpty {
            sortName.removeLast(2)
            dataSource.addTemporarySortSelect(sortName)
        }
        view.reloadPickerView()
    }

    func setTextField(_ text: String) {
        defer { view.updateSortItem(editingNubmer) }
        let numberToRemove = sort.count - editingNubmer - 1
        let isLast = editingNubmer == sort.count - 1
        if !text.isEmpty {
			if isLast {
                sort.append(.none)
            }
        } else if numberToRemove > 0 {
            dataSource.appendSortSelect(Array(
				sort[editingNubmer ... sort.count - 2].map { var el = $0 ?? ""; el.removeLast(2); return el }
			))
            sort.removeLast(numberToRemove)
        }
        sort[editingNubmer] = text
        dataSource.updateForSections([
            FilterSectionModel(filters.map { FilterModel(name: $0.key, value: $0.value) }),
            SortSectionModel(sort.enumerated().map { SortModel(
								sortName: $0.element,
								isActive: true,
								number: $0.offset,
								inputView: view.pickerView
			)
            })
        ])
        if !text.isEmpty {
            if isLast {
                view.insertRow(at: IndexPath(row: editingNubmer + 1, section: 1))
            }
        } else if numberToRemove > 0 {
            view.removeRows(after: IndexPath(row: editingNubmer, section: 1), number: numberToRemove)
        }
    }
    func textFieldResignFirstResponder() {
        defer { view.updateSortItem(editingNubmer) }
    }

    func selectPicker(at row: Int) {
        view.selectPicker(at: row)
    }
}

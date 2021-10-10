//
//  FiltersPresenter.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import Foundation
import OrderedCollections

class FiltersPresenter: ViewToPresenterFiltersProtocol {

    // MARK: Properties
    weak var view: PresenterToViewFiltersProtocol!
    let interactor: PresenterToInteractorFiltersProtocol
    let router: PresenterToRouterFiltersProtocol
    let dataSource:PresenterToDataSourceFiltersProtocol
    let delegate: TableViewToFiltersDelegateProtocol
    var filters: OrderedDictionary<String, Bool> = [ .myCursus: false,
                                                     .myCampus: false,
                                                     .future: false,
                                                     .didSubscribe: false]
    // MARK: Init
    init(view: PresenterToViewFiltersProtocol,
         interactor: PresenterToInteractorFiltersProtocol,
         router: PresenterToRouterFiltersProtocol,
         dataSource: PresenterToDataSourceFiltersProtocol,
         delegate: TableViewToFiltersDelegateProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
        self.delegate = delegate
    }

    func viewDidLoad(){
    }

    func viewWillAppear() {
        if let filters = interactor.loadFilters() {
            self.filters = filters
        }
        dataSource.updateForSections([FilterSectionModel(filters.map{ FilterModel(name: $0.key, value: $0.value) })])
    }

    func viewDidDisappear() {
        delegate.refresh(with: filters)
        interactor.saveFilters(filters: filters)
    }
}

extension FiltersPresenter: CellToPresenterFiltersProtocol {
    func switcherDidChanged(_ title: String) {
        filters[title]?.toggle()
    }
}

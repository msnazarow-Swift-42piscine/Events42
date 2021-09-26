//
//  EventPresenter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import Foundation

class EventPresenter: ViewToPresenterEventProtocol {

    // MARK: Properties
    weak var view: PresenterToViewEventProtocol!
    let interactor: PresenterToInteractorEventProtocol
    let router: PresenterToRouterEventProtocol
    let dataSource:PresenterToDataSourceEventProtocol

    // MARK: Init
    init(view: PresenterToViewEventProtocol,
         interactor: PresenterToInteractorEventProtocol,
         router: PresenterToRouterEventProtocol,
         dataSource: PresenterToDataSourceEventProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){

    }
}

extension EventPresenter: CellToPresenterEventProtocol {
    
}

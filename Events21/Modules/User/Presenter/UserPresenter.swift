//
//  UserPresenter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import Foundation

class UserPresenter: ViewToPresenterUserProtocol {

    // MARK: Properties
    weak var view: PresenterToViewUserProtocol!
    let interactor: PresenterToInteractorUserProtocol
    let router: PresenterToRouterUserProtocol
    let dataSource:PresenterToDataSourceUserProtocol

    // MARK: Init
    init(view: PresenterToViewUserProtocol,
         interactor: PresenterToInteractorUserProtocol,
         router: PresenterToRouterUserProtocol,
         dataSource: PresenterToDataSourceUserProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){

    }
}

extension UserPresenter: CellToPresenterUserProtocol {
    
}

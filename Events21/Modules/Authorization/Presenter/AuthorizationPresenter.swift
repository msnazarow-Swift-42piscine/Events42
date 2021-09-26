//
//  AuthorizationPresenter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import Foundation

class AuthorizationPresenter: ViewToPresenterAuthorizationProtocol {

    // MARK: Properties
    weak var view: PresenterToViewAuthorizationProtocol!
    let interactor: PresenterToInteractorAuthorizationProtocol
    let router: PresenterToRouterAuthorizationProtocol
    let dataSource:PresenterToDataSourceAuthorizationProtocol

    // MARK: Init
    init(view: PresenterToViewAuthorizationProtocol,
         interactor: PresenterToInteractorAuthorizationProtocol,
         router: PresenterToRouterAuthorizationProtocol,
         dataSource: PresenterToDataSourceAuthorizationProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){
//        interactor.getRecentEvents(for: "sgertrud") { result in
//            print(result)
//        }
    }
    func didTapLoginButton() {
        interactor.openIntra()
    }
}
 
extension AuthorizationPresenter: CellToPresenterAuthorizationProtocol {
    
}

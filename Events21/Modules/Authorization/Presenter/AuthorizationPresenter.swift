//
//  AuthorizationPresenter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import Foundation
import WebKit


class AuthorizationPresenter: NSObject, ViewToPresenterAuthorizationProtocol {

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
        if interactor.hasToken() {
            router.routeToUserScreen()
        }
    }
    
    func buttonDidTapped() {
//        router.routeToWebView()
        interactor.getToken { result in
            switch result {
            case .success(let token):
                self.router.routeToUserScreen()
            case .failure(let error):
                if let description = error.errorDescription {
                    self.view.showAlert(title: error.error, message: description)
                } else if let message = error.message {
                    self.view.showAlert(title: error.error, message: message)
                }
            }
        }
    }
}
 
extension AuthorizationPresenter: CellToPresenterAuthorizationProtocol {
    
}

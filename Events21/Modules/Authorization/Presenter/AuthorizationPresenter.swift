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
        guard interactor.hasToken() else { return }
        if !interactor.tokenIsOutdated() {
			loadMe() { [weak self] in
	//				self?.refresh(
	//					filters: self?.interactor.loadFilters() ?? [
	//						.myCursus: false,
	//						.myCampus: false,
	//						.future: false,
	//						.didSubscribe: false
	//					],
	//					sort:  []
	//				)
			}
        } else {
            interactor.refreshToken { [weak self] _ in
				self?.loadMe() {
		//				self?.refresh(
		//					filters: self?.interactor.loadFilters() ?? [
		//						.myCursus: false,
		//						.myCampus: false,
		//						.future: false,
		//						.didSubscribe: false
		//					],
		//					sort:  []
		//				)
				}
            }
        }
    }
    
    func buttonDidTapped() {
//        router.routeToWebView()
        interactor.getToken { [weak self] result in
            switch result {
            case .success(let token):
				self?.loadMe() { [weak self] in
		//				self?.refresh(
		//					filters: self?.interactor.loadFilters() ?? [
		//						.myCursus: false,
		//						.myCampus: false,
		//						.future: false,
		//						.didSubscribe: false
		//					],
		//					sort:  []
		//				)
				}
            case .failure(let error):
                if let description = error.errorDescription {
                    self?.view.showAlert(title: error.error, message: description)
                } else if let message = error.message {
                    self?.view.showAlert(title: error.error, message: message)
                }
            }
        }
    }
	

	func loadMe(comletion: @escaping (() -> Void)) {
		interactor.getMe() { [weak self] result in
			switch result {
			case .success(let me):
				self?.router.routeToUserScreen(me: me)

			case .failure(let error):
				if let description = error.errorDescription {
					self?.view.showAlert(title: error.error, message: description) {
						self?.interactor.removeToken()
						self?.view.setLoginButtonHidden(false)
//						self.router.routeToAuthScreen()
					}
				} else if let message = error.message {
					self?.view.showAlert(title: error.error, message: message) {
						self?.interactor.removeToken()
							self?.view.setLoginButtonHidden(false)
//						self.router.routeToAuthScreen()
					}
				}
			}
		}
	}
}
 
extension AuthorizationPresenter: CellToPresenterAuthorizationProtocol {
    
}

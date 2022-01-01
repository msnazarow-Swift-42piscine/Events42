//
//  AuthorizationContract.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit
import WebKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewAuthorizationProtocol: AnyObject {
    func loadRequest(request: URLRequest)
    func showAlert(title: String, message: String, completion: (() -> Void)?)
	func setLoginButtonHidden(_ hidden: Bool)
}

extension PresenterToViewAuthorizationProtocol {
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, completion: nil)
    }
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAuthorizationProtocol: AnyObject, WKNavigationDelegate {
    var dataSource:PresenterToDataSourceAuthorizationProtocol { get }
    func viewDidLoad()
	func viewWillAppear()
    func buttonDidTapped()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAuthorizationProtocol: AnyObject {
    func getUserCode(completion: @escaping (Result<String, IntraAPIError>) -> Void)
    func getToken(completion: @escaping (Result<String, IntraAPIError>) -> Void)
    func refreshToken(completion: @escaping (Result<String, IntraAPIError>) -> Void)
    func hasToken() -> Bool
    func tokenIsOutdated() -> Bool
	func getMe(comletion: @escaping (Result<UserFullModel, IntraAPIError>) -> Void)
	func removeToken()

}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterAuthorizationProtocol: AnyObject {
//	func routeToAuthScreen()
	func routeToUserScreen(me: UserFullModel)
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceAuthorizationProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [EventListSection])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterAuthorizationProtocol: AnyObject {

}

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
    func didTapLoginButton()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAuthorizationProtocol: AnyObject {
    func getAuthRequest() -> URLRequest
    func getUserCode(completion: @escaping (Result<String, IntraAPIError>) -> Void)
    func getToken(completion: @escaping (Result<String, IntraAPIError>) -> Void)
    func hasToken() -> Bool
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterAuthorizationProtocol: AnyObject {
    func routeToUserScreen()
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceAuthorizationProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [SectionModel])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterAuthorizationProtocol: AnyObject {

}

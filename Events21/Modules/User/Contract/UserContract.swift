//
//  UserContract.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewUserProtocol: AnyObject {
    func setProfileImageView(image: UIImage)
    func setLogin(_ login: String)
    func setName(_ name: String)
    func setSurname(_ surname: String)
    func setLevel(_ level: String)
    func reloadTableViewData()
    func showAlert(title: String, message: String, completion: (() -> Void)?)
}

extension PresenterToViewUserProtocol {
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, completion: nil)
    }
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterUserProtocol: AnyObject {
    var dataSource:PresenterToDataSourceUserProtocol { get }

    func viewDidLoad()
    func didSelectRowAt(modelId: Int)
    func buttonDidTapped(_ title: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorUserProtocol: AnyObject {
    func getRecentEvents(sort: [String], filter: [String: [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void)
    func getUserEvents(completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void)
    func getMe(comlition: @escaping (Result<MeResponse, IntraAPIError>) -> Void)
    func getImage(for url: String, completion: @escaping (UIImage?) -> Void)
    func removeToken()
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterUserProtocol: AnyObject {
    func routeToEventScreen(with event: EventCellModel, userId: Int)
    func routeToAuthScreen()
    func presentFilterScreen()
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceUserProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [EventSectionModel])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterUserProtocol: AnyObject {

}

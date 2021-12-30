//
//  UserMainContract.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewUserMainProtocol: AnyObject {
	func setProfileImageView(image: UIImage)
	func setLogin(_ login: String)
	func setName(_ name: String)
	func setSurname(_ surname: String)
	func setLevel(_ level: String)
	func showAlert(title: String, message: String, completion: (() -> Void)?)
	func showAlertQuestion(title: String, message: String, completion: (() -> Void)?)
}

extension PresenterToViewUserMainProtocol {
	func showAlert(title: String, message: String) {
		showAlert(title: title, message: message, completion: nil)
	}
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterUserMainProtocol: AnyObject {
    var dataSource: PresenterToDataSourceUserMainProtocol { get }
    func viewDidLoad()
	func logoutButtonTapped()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorUserMainProtocol: AnyObject {
	func getImage(for url: URL, completion: @escaping (UIImage?) -> Void)
	func removeToken()
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterUserMainProtocol: AnyObject {
	func routeToAuthScreen()
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceUserMainProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [TableViewSectionProtocol])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterUserMainProtocol: AnyObject {

}

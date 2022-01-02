//
//  SearchUserContract.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchUserProtocol: AnyObject {
	func tableViewReload()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchUserProtocol: AnyObject {
    var dataSource: PresenterToDataSourceSearchUserProtocol { get }

    func viewDidLoad()
	func updateSearchResults(_ text: String?)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchUserProtocol: AnyObject {
	func getUsers(
		sort: [String],
		filter: [String: [String]],
		completion: @escaping (Result<[UserShortModel], IntraAPIError>) -> Void
	)
	func getUser(userId: Int, completion: @escaping (Result<UserFullModel, IntraAPIError>) -> Void)
}

extension PresenterToInteractorSearchUserProtocol {
	func getUsers(
		filter: [String: [String]],
		completion: @escaping (Result<[UserShortModel], IntraAPIError>) -> Void) {
		getUsers(sort: [], filter: filter, completion: completion)
	}
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterSearchUserProtocol: AnyObject {
	func routeToUser(user: UserFullModel)
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceSearchUserProtocol: UITableViewDataSource, UITableViewDelegate {
    func updateForSections(_ sections: [TableViewSectionProtocol])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterSearchUserProtocol: AnyObject {
	func didSelectUser(userId: Int)
}

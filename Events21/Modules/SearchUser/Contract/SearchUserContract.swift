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

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchUserProtocol: AnyObject {
    var dataSource:PresenterToDataSourceSearchUserProtocol { get }

    func viewDidLoad()
	func updateSearchResults(_ text: String?)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchUserProtocol: AnyObject {
	func getUsers(userId: Int?, eventId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void)
}

extension PresenterToInteractorSearchUserProtocol {
	func getUsers(filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
		getUsers(userId: nil, eventId: nil, sort: [], filter: filter, completion: completion)
	}
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterSearchUserProtocol: AnyObject {
    
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceSearchUserProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [TableViewSectionProtocol])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterSearchUserProtocol: AnyObject {

}

//
//  EventContract.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewEventProtocol: AnyObject {
    func setTextView(text: NSAttributedString)
    func showAlert(with message: String)
    func setButtonUnregistered()
    func setButtonRegistered()
    func showAlert(title: String, message: String, completion: (() -> Void)?)
    func hideButton()
    func show()
}

extension PresenterToViewEventProtocol {
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, completion: nil)
    }
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterEventProtocol: AnyObject {
    var dataSource: PresenterToDataSourceEventProtocol { get }
    func viewDidLoad()
    func buttonDidTapped()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorEventProtocol: AnyObject {
    func getUserEvents(
		userIds: [Int],
		eventIds: [Int],
		sort: [String],
		filter: [String: [String]],
		completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void
	)
    func registerToEvent(eventId: Int, completion: @escaping (Result<EventUsersResponse, IntraAPIError>) -> Void)
    func unregisterFromEvent(eventUserId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void)
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterEventProtocol: AnyObject {
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceEventProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [EventListSection])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterEventProtocol: AnyObject {
}

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
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterEventProtocol: AnyObject {
    var dataSource:PresenterToDataSourceEventProtocol { get }
    func viewDidLoad()
    func didTapButton()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorEventProtocol: AnyObject {
    func registerToEvent(userId: Int, eventId: Int, complition: @escaping (Bool) -> Void)
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterEventProtocol: AnyObject {
    
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceEventProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [SectionModel])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterEventProtocol: AnyObject {

}

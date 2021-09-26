//
//  AuthorizationContract.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewAuthorizationProtocol: AnyObject {

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAuthorizationProtocol: AnyObject {
    var dataSource:PresenterToDataSourceAuthorizationProtocol { get }
    func viewDidLoad()
    func didTapLoginButton()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAuthorizationProtocol: AnyObject {
    func openIntra()
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterAuthorizationProtocol: AnyObject {
    
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceAuthorizationProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [SectionModel])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterAuthorizationProtocol: AnyObject {

}

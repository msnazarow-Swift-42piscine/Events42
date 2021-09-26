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
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterUserProtocol: AnyObject {
    var dataSource:PresenterToDataSourceUserProtocol { get }
    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorUserProtocol: AnyObject {
    func getRecentEvents(for userID: String, complition: @escaping (Result<[EventResponse], Error>) -> Void)
    func getMe(with token: String, comlition: @escaping (MeResponse) -> Void)
    func getToken(with code: String, complition: @escaping (String) -> Void)
    func getImage(for url: String, complition: @escaping (UIImage?) -> Void)
}

// MARK: Presenter Output (Presenter -> Router)
protocol PresenterToRouterUserProtocol: AnyObject {
    
}

// MARK: Presenter Output (Presenter -> DataSource)
protocol PresenterToDataSourceUserProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [SectionModel])
}

// MARK: Cell Input (Cell -> Presenter)
protocol CellToPresenterUserProtocol: AnyObject {

}

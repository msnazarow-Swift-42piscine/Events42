//
//  UserPresenter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import Foundation

class UserPresenter: ViewToPresenterUserProtocol {

    // MARK: Properties
    weak var view: PresenterToViewUserProtocol!
    let interactor: PresenterToInteractorUserProtocol
    let router: PresenterToRouterUserProtocol
    let dataSource:PresenterToDataSourceUserProtocol

    // MARK: Init
    init(view: PresenterToViewUserProtocol,
         interactor: PresenterToInteractorUserProtocol,
         router: PresenterToRouterUserProtocol,
         dataSource: PresenterToDataSourceUserProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){
        if let code = UserDefaults.standard.value(forKey: .userToken) as? String {
//            interactor.getMe(with: code)
            interactor.getToken(with: code) {[self] token in
                interactor.getMe(with: token) { me in
                    
                    view.setName(me.firstName)
                    view.setSurname(me.lastName)
                    view.setLogin(me.login)
                    guard let cursus = me.cursusUsers.first,
                          let level = cursus.level else { return }
                    view.setLevel("\(level)")
                    interactor.getImage(for: me.imageUrl) { image in
                        guard let image = image else { return }
                        view.setProfileImageView(image: image)
                    }
                }
            }
        }

    }
}

extension UserPresenter: CellToPresenterUserProtocol {
    
}

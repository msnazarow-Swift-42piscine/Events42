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
            interactor.getToken(with: code) {[self] token in
                getMe(with: token)
                getRecentEvents(with: token)
            }
        }
    }
    func getMe(with token: String) {
        interactor.getMe(with: token) { [self] me in
            view.setName(me.firstName)
            view.setSurname(me.lastName)
            view.setLogin(me.login)
            guard let cursuses = me.cursusUsers else { return }
            var levels = ""
            cursuses.forEach{ cursus in
                if let name = cursus.cursus.name, let level = cursus.level {
                    levels.append("\(name) \(level)\n")
                }
            }
            view.setLevel("\(levels)")
            interactor.getImage(for: me.imageUrl) { image in
                guard let image = image else { return }
                view.setProfileImageView(image: image)
            }
        }
    }
    func getRecentEvents(with token: String) {
        interactor.getRecentEvents(with: token) { result in
            switch result {
            case .success(let responses):
                self.dataSource.updateForSections([SectionModel(responses)])
                self.view.reloadTableViewData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UserPresenter: CellToPresenterUserProtocol {
    
}

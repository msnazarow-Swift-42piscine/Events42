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

    var events: [EventResponse]!
    var userId: Int!

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
        getMe() {
            self.getRecentEvents(sort: [], filter: [:])
//            self.getUserEvents()
        }
    }
    
    func getMe(comletion: @escaping (() -> Void)) {
        interactor.getMe() { [unowned self] result in
            switch result {
            case .success(let me):
                userId = me.id
                view.setName(me.firstName)
                view.setSurname(me.lastName)
                view.setLogin(me.login)
                var levels = ""
                me.cursusUsers.forEach{ cursus in
                    levels.append("\(cursus.cursus.name) \(cursus.level)\n")
                }
                view.setLevel("\(levels)")
                interactor.getImage(for: me.imageUrl) { image in
                    guard let image = image else { return }
                    view.setProfileImageView(image: image)
                }
                comletion()
            case .failure(let error):
                if let description = error.errorDescription {
                    self.view.showAlert(title: error.error, message: description) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                } else if let message = error.message {
                    self.view.showAlert(title: error.error, message: message) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                }
            }

        }
    }

    func getRecentEvents(sort: [String], filter: [String : [String]]) {
        interactor.getRecentEvents(sort: sort, filter: filter) { result in
            switch result {
            case .success(let responses):
                self.events = responses
                self.dataSource.updateForSections([EventSectionModel(self.events)])
                self.view.reloadTableViewData()
            case .failure(let error):
                if let description = error.errorDescription {
                    self.view.showAlert(title: error.error, message: description) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                } else if let message = error.message {
                    self.view.showAlert(title: error.error, message: message) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                }
            }
        }
    }

    func getUserEvents() {
        interactor.getUserEvents { result in
            switch result {
            case .success(let responses):
                self.events = responses.map{ $0.event }
                self.dataSource.updateForSections([EventSectionModel(self.events)])
                self.view.reloadTableViewData()
            case .failure(let error):
                if let description = error.errorDescription {
                    self.view.showAlert(title: error.error, message: description) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                } else if let message = error.message {
                    self.view.showAlert(title: error.error, message: message) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                }
            }
        }
    }

    func didSelectRowAt(modelId: Int) {
        router.routeToEventScreen(with: EventCellModel(events[modelId]), userId: userId)
    }

    func buttonDidTapped(_ title: String) {
        switch title {
        case .filters:
            router.presentFilterScreen()
        case .logOut:
            self.interactor.removeToken()
            self.router.routeToAuthScreen()
        default:
            break
        }
    }
}

extension UserPresenter: CellToPresenterUserProtocol {
    
}

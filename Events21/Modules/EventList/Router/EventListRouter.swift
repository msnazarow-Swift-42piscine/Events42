//
//  EventListRouter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

class EventListRouter: PresenterToRouterUserProtocol {

    // MARK: - Properties
    weak var view: UIViewController?

    // MARK: - Init
    init(view: UIViewController) {
        self.view = view
    }

    func routeToEventScreen(with model: EventResponse, userId: Int) {
        DispatchQueue.main.async {
            self.view?.navigationController?.pushViewController(EventDetailAssembly.createModule(with: model, userId: userId), animated: true)
        }
    }

    func routeToAuthScreen(){
        DispatchQueue.main.async {
			self.view?.tabBarController?.navigationController?.popViewController(animated: true)
//            self.view.navigationController?.setViewControllers([AuthorizationAssembly.createModule()], animated: true)
        }
    }

    func presentFilterScreen(delegate: TableViewToFiltersDelegateProtocol) {
        DispatchQueue.main.async {
			self.view?.navigationController?.pushViewController(EventListFiltersAssembly.createModule(delegate: delegate), animated: true)
        }
    }
}

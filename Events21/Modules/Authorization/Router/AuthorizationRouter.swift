//
//  AuthorizationRouter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit
import WebKit

class AuthorizationRouter: PresenterToRouterAuthorizationProtocol {

    // MARK: - Properties
    weak var view: UIViewController!

    // MARK: - Init
    init(view: UIViewController) {
        self.view = view
    }

    func routeToUserScreen() {
        DispatchQueue.main.async {
            self.view.navigationController?.setViewControllers([UserAssembly.createModule()], animated: true)
        }
    }
}

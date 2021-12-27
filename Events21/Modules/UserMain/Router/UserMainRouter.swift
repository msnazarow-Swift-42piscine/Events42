//
//  UserMainRouter.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit

class UserMainRouter: PresenterToRouterUserMainProtocol {

    // MARK: - Properties
    weak var view: UIViewController!

	func routeToAuthScreen() {
		DispatchQueue.main.async { [weak self] in
			self?.view.navigationController?.setViewControllers([AuthorizationAssembly.createModule()], animated: true)
		}
	}
}

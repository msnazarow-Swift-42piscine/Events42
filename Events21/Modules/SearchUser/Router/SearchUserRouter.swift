//
//  SearchUserRouter.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//  
//

import UIKit

class SearchUserRouter: PresenterToRouterSearchUserProtocol {
    // MARK: - Properties
    weak var view: UIViewController?

	func routeToUser(user: UserFullModel) {
		DispatchQueue.main.async {
			self.view?.navigationController?.pushViewController(UserMainAssembly.createModule(me: user), animated: true)
		}
	}
}

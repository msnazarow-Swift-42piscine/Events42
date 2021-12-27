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

	func routeToUserScreen(me: MeResponse) {
        DispatchQueue.main.async { [weak self] in
			let tabView = UITabBarController()
			let nav1 = UINavigationController(rootViewController: UserMainAssembly.createModule(me: me))
			nav1.navigationBar.backgroundColor = UIColor(patternImage: UIImage(named: "background")!
			)
			let nav2 = UINavigationController(rootViewController: EventListAssembly.createModule(me: me))
			nav2.navigationBar.backgroundColor = UIColor(patternImage: UIImage(named: "background")!
			)
			tabView.viewControllers = [nav1, nav2]
			tabView.tabBar.barTintColor = UIColor(patternImage: UIImage(named: "background")!)
            self?.view.navigationController?.setViewControllers([tabView], animated: true)
        }
    }
}

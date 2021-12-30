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

	func routeToUserScreen(me: UserFullModel) {
        DispatchQueue.main.async { [weak self] in
			let tabView = UITabBarController()
			let nav1 = UINavigationController(rootViewController: UserMainAssembly.createModule(me: me))
			nav1.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "background")!)
			nav1.tabBarItem = UITabBarItem(
				title: "Main",
				image: UIImage(systemName: "person"),
				tag: 0
			)
			let nav2 = UINavigationController(rootViewController: SearchUserAssembly.createModule())
			nav2.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "background")!)
			nav2.tabBarItem = UITabBarItem(
				title: "Search",
				image: UIImage(systemName: "magnifyingglass"),
				tag: 1
			)
			let nav3 = UINavigationController(rootViewController: EventListAssembly.createModule(me: me))
			nav3.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "background")!)
			nav3.tabBarItem = UITabBarItem(
				title: "Events",
				image: UIImage(systemName: "calendar"),
				tag: 2
			)
			tabView.viewControllers = [nav1, nav2, nav3]
			tabView.tabBar.barTintColor = UIColor(patternImage: UIImage(named: "background")!)
			self?.view.navigationController?.pushViewController(tabView, animated: true)
//            self?.view.navigationController?.setViewControllers()
        }
    }
}

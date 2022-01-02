//
//  SceneDelegate.swift
//  Events21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: AuthorizationAssembly.createModule())
		window?.makeKeyAndVisible()
    }
}

//
//  UserRouter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

class UserRouter: PresenterToRouterUserProtocol {

    // MARK: - Properties
    weak var view: UIViewController!

    // MARK: - Init
    init(view: UIViewController) {
        self.view = view
    }
    
}

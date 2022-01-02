//
//  EventListFiltersRouter.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit

class EventListFiltersRouter: PresenterToRouterFiltersProtocol {
    // MARK: - Properties
    weak var view: UIViewController?

    // MARK: - Init
    init(view: UIViewController) {
        self.view = view
    }
}

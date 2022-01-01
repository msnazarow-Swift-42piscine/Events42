//
//  UserMainAssembly.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit

enum UserMainAssembly{
    
    // MARK: Static methods
	static func createModule(me: UserFullModel) -> UIViewController {
        let router = UserMainRouter()
		let intraAPIService = IntraAPIService.shared
		let imageCashingService = ImageCashingService.shared
        let interactor = UserMainInteractor(
			intraAPIService: intraAPIService,
			imageCashingService: imageCashingService)
        let dataSource = UserMainDataSource()
        let presenter = UserMainPresenter(
            interactor: interactor,
            router: router,
            dataSource: dataSource,
			me: me
        )
        let view = UserMainViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        dataSource.presenter = presenter

        return view
    }
}

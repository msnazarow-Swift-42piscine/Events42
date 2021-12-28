//
//  SearchUserPresenter.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//  
//

import Foundation

class SearchUserPresenter: ViewToPresenterSearchUserProtocol {

    // MARK: Properties
    weak var view: PresenterToViewSearchUserProtocol?
    let interactor: PresenterToInteractorSearchUserProtocol
    let router: PresenterToRouterSearchUserProtocol
    let dataSource:PresenterToDataSourceSearchUserProtocol
	var debounceTimer: Timer?

    // MARK: Init
    init(
        interactor: PresenterToInteractorSearchUserProtocol,
        router: PresenterToRouterSearchUserProtocol,
        dataSource: PresenterToDataSourceSearchUserProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){

    }

	func updateSearchResults(_ text: String?) {
		guard let text = text, !text.isEmpty else {
			return
		}
		debounceTimer?.invalidate()
		debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
//			self?.downloadNewData()
			print("hello world")
			self?.interactor.getUsers(filter: ["login" : [text]]) { (result) in
				
			}
		}
	}
}

extension SearchUserPresenter: CellToPresenterSearchUserProtocol {
    
}

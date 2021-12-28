//
//  UserMainPresenter.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import OrderedCollections

class UserMainPresenter: ViewToPresenterUserMainProtocol {

    // MARK: Properties
    weak var view: PresenterToViewUserMainProtocol!
    let interactor: PresenterToInteractorUserMainProtocol
    let router: PresenterToRouterUserMainProtocol
    let dataSource:PresenterToDataSourceUserMainProtocol
	let me: MeResponse

    // MARK: Init
    init(
        interactor: PresenterToInteractorUserMainProtocol,
        router: PresenterToRouterUserMainProtocol,
        dataSource: PresenterToDataSourceUserMainProtocol,
		me: MeResponse
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
		self.me = me
    }

    func viewDidLoad(){
		updateView()
    }

	private func updateView() {
		view.setName(me.firstName)
		view.setSurname(me.lastName)
		view.setLogin(me.login)
		var levels = ""
		me.cursusUsers.forEach{ cursus in
			levels.append("\(cursus.cursus.name) \(cursus.level)\n")
		}
		view.setLevel("\(levels)")
		interactor.getImage(for: me.imageUrl) { [weak self] image in
			guard let image = image else { return }
			self?.view.setProfileImageView(image: image)
		}
//		comletion()
	}

	func refresh(filters: OrderedDictionary<String, Bool>, sort: [String?]) {
		var interactorFilter: [String: [String]] = [:]
		if let future = filters[.future], future {
			interactorFilter[.future] = ["true"]
		}
//
//		let predicates: [(EventResponse, EventResponse) -> Bool] = sort.compactMap{ sortName in
//			guard let sortName = sortName else { return nil }
//			return self.predicates[sortName]
//		}
//		loadEvents(campusIds: filters[.myCampus]! ? me.campus.map{ $0.id } : [],
//				   cursusIds: filters[.myCursus]! ? me.cursusUsers.map{ $0.cursusId } : [] ,
//				   userIds: filters[.didSubscribe]! ? [me.id] : [],
//				   sort: [],
//				   filter: interactorFilter,
//				   sortedByPredicates: predicates)
	}

	func logoutButtonTapped() {
		view.showAlertQuestion(title: "Do you want to logout?", message: "") {
			self.interactor.removeToken()
			self.router.routeToAuthScreen()
		}
	}

}

extension UserMainPresenter: CellToPresenterUserMainProtocol {
    
}

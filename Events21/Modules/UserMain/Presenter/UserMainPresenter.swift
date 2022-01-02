//
//  UserMainPresenter.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import OrderedCollections
import UIKit

class UserMainPresenter: ViewToPresenterUserMainProtocol {

    // MARK: Properties
    weak var view: PresenterToViewUserMainProtocol!
    let interactor: PresenterToInteractorUserMainProtocol
    let router: PresenterToRouterUserMainProtocol
    let dataSource:PresenterToDataSourceUserMainProtocol
	let me: UserFullModel
	var cursusUser: CursusUserResponse?

    // MARK: Init
    init(
        interactor: PresenterToInteractorUserMainProtocol,
        router: PresenterToRouterUserMainProtocol,
        dataSource: PresenterToDataSourceUserMainProtocol,
		me: UserFullModel
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
		self.me = me
		self.cursusUser = me.cursusUsers.last
    }

    func viewDidLoad(){
		updateView()
    }

	private func updateView() {
		dataSource.updateForHeader([UserHeaderModel(me)])
		dataSource.updateForSections([
			TasksSubtitleIconSection([
				SubtitleIconModel(title: "Skills", subTitle: "", icon: "chevron.right"),
				SubtitleIconModel(title: "Projects", subTitle: "", icon: "chevron.right"),
				SubtitleIconModel(title: "Achievements", subTitle: "", icon: "chevron.right"),
			])
		])
		view.tableViewReload()
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
	func didSelectRowAt(_ indexPath: IndexPath) {
		guard let cursusUser = cursusUser else { return }
		switch indexPath.row {
		case 0:
			router.routeToSkills(skills: cursusUser.skills)
		case 1:
			router.routeToProjects(projects: me.projectsUsers.filter { $0.project.parentId == nil && $0.cursusIds.contains(cursusUser.cursusId) })
		case 2:
			router.routeToAchievements(achievements: me.achievements)
		default: break
		}
	}

	func didSelectCursus(_ cursusUser: CursusUserResponse) {
		self.cursusUser = cursusUser
	}
}

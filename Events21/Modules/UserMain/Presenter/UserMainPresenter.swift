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
    let dataSource: PresenterToDataSourceUserMainProtocol
	let user: UserFullModel
	var cursusUser: CursusUserResponse?

    // MARK: Init
    init(
        interactor: PresenterToInteractorUserMainProtocol,
        router: PresenterToRouterUserMainProtocol,
        dataSource: PresenterToDataSourceUserMainProtocol,
		user: UserFullModel
    ) {
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
		self.user = user
		self.cursusUser = user.cursusUsers.last
    }

    func viewDidLoad() {
		updateView()
    }

	private func updateView() {
		dataSource.updateForHeader([UserHeaderModel(user)])
		dataSource.updateForSections([
			TasksSubtitleIconSection([
				SubtitleIconModel(title: "Skills", subTitle: "", icon: "chevron.right"),
				SubtitleIconModel(title: "Projects", subTitle: "", icon: "chevron.right"),
				SubtitleIconModel(title: "Achievements", subTitle: "", icon: "chevron.right")
			])
		])
		view.tableViewReload()
	}

	func refresh(filters: OrderedDictionary<String, Bool>, sort: [String?]) {
		var interactorFilter: [String: [String]] = [:]
		if let future = filters[.future], future {
			interactorFilter[.future] = ["true"]
		}
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
			router.routeToProjects(
				projects: user.projectsUsers.filter {
					$0.project.parentId == nil && $0.cursusIds.contains(cursusUser.cursusId) && $0.status != .parent
				}
			)
		case 2:
			router.routeToAchievements(achievements: user.achievements)
		default: break
		}
	}

	func didSelectCursus(_ cursusUser: CursusUserResponse) {
		self.cursusUser = cursusUser
	}
}

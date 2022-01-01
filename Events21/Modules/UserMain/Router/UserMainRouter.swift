//
//  UserMainRouter.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit

class UserMainRouter: PresenterToRouterUserMainProtocol {

    // MARK: - Properties
    weak var view: UIViewController?

	func routeToAuthScreen() {
		DispatchQueue.main.async { [weak self] in
			self?.view?.tabBarController?.navigationController?.popViewController(animated: true)
		}
	}

	func routeToSkills(skills: [SkillModel]) {
		DispatchQueue.main.async { [weak self] in
			self?.view?.navigationController?.pushViewController(SkillsAssembly.createModule(skills: skills), animated: true)
		}
	}

	func routeToAchievements(achievements: [AchievementResponse]) {
		DispatchQueue.main.async { [weak self] in
			self?.view?.navigationController?.pushViewController(AchievementsAssembly.createModule(achievements: achievements), animated: true)
		}
	}

	func routeToProjects(projects: [ProjectUser], cursusId: Int) {
		DispatchQueue.main.async { [weak self] in
			self?.view?.navigationController?.pushViewController(ProjectsAssembly.createModule(projects: projects, cursusId: cursusId), animated: true)
		}
	}
}

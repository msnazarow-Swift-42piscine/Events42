//
//  SearchUserInteractor.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//  
//

import Foundation

class SearchUserInteractor: PresenterToInteractorSearchUserProtocol {

	let intraAPIservice: IntraAPIServiceProtocol

	init(intraAPIservice: IntraAPIServiceProtocol) {
		self.intraAPIservice = intraAPIservice
	}

	func getUsers(userId: Int?, eventId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[UserShortModel], IntraAPIError>) -> Void) {
		intraAPIservice.getUsers(userId: userId, eventId: eventId, sort: sort, filter: filter, completion: completion)
	}

	func getUser(userId: Int, completion: @escaping (Result<UserFullModel, IntraAPIError>) -> Void) {
		intraAPIservice.getUser(userId: userId, completion: completion)
	}

}

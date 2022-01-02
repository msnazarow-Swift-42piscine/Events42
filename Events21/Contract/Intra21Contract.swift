//
//  Intra21Contract.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit
import OrderedCollections
import AuthenticationServices

let verticalTranslation = max(
	!UIWindow.isLandscape ?
	UIScreen.main.bounds.height / 844.0 :
	UIScreen.main.bounds.height / 390.0, 1
)
let horisontalTranslation = max(
	!UIWindow.isLandscape ?
	UIScreen.main.bounds.width / 390.0 :
	UIScreen.main.bounds.width / 844.0, 1
)

protocol FiltersStorageProtocol {
	func saveFilters(filters: OrderedDictionary<String, Bool>)
	func loadFilters() -> OrderedDictionary<String, Bool>?
}

protocol ImageCashingServiceProtocol {
	func getImage(for url: URL, comletion: @escaping (UIImage?) -> Void)
	func saveImage(for url: URL, image: UIImage)
}

protocol IntraAPIServiceProtocol {
	func getEvents(
		campusId: Int?,
		cursusId: Int?,
		userId: Int?,
		sort: [String],
		filter: [String: [String]],
		completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void
	)
	func registerToEvent(eventId: Int, completion: @escaping (Result<EventUsersResponse, IntraAPIError>) -> Void)
	func unregisterFromEvent(eventUserId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void)
	func getUserEvents(
		userId: Int?,
		eventId: Int?,
		sort: [String],
		filter: [String: [String]],
		completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void
	)
	func getMe(completion: @escaping (Result<UserFullModel, IntraAPIError>) -> Void)
	func getToken(completion: @escaping (Result<String, IntraAPIError>) -> Void)
	func getUserCode(completion: @escaping (Result<String, IntraAPIError>) -> Void)
	func removeCode()
	func removeToken()
	func hasToken() -> Bool
	func tokenIsOutdated() -> Bool
	func refreshToken(completion: @escaping (Result<String, IntraAPIError>) -> Void)
	func getUsers(
		sort: [String],
		filter: [String: [String]],
		completion: @escaping (Result<[UserShortModel], IntraAPIError>) -> Void
	)
	func getUser(userId: Int, completion: @escaping (Result<UserFullModel, IntraAPIError>) -> Void)
}

//
//  UserResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 12.10.2021.
//

import Foundation

struct UserShortModel: Codable {
	let id: Int
	let email: String
	let login: String
	let firstName: String
	let lastName: String
	let usualFullName: String?
	let usualFirstName: String?
	let url: URL
	let phone: String?
	let displayname: String
	let imageUrl: URL
	let staff: Bool
	let correctionPoint: Int
	let poolMonth: String?
	let poolYear: String?
	let location: String?
	let wallet: Int
	let alumni: Bool?
	let isLaunched: Bool?

	enum CodingKeys: String, CodingKey {
		case id
		case email
		case login
		case firstName
		case lastName
		case usualFullName
		case usualFirstName
		case url
		case phone
		case displayname
		case imageUrl
		case staff = "staff?"
		case correctionPoint
		case poolMonth
		case poolYear
		case location
		case wallet
		case alumni
		case isLaunched = "is_launched?"
	}
}

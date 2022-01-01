//
//  UserHeaderModel.swift
//  Events21
//
//  Created by 19733654 on 30.12.2021.
//

import Foundation

struct UserHeaderModel: Identifiable {
	let identifier = "UserHeader"
	let name: String
	let email: String
	let imageUrl: URL
	let staff: Bool
	let location: String
	let phone: String
	let wallet: String
	let correctionPoints: String
	let cursuses: [CursusUserResponse]
	var pool: String?

	init(_ property: UserFullModel) {
		name = "\(property.firstName) \(property.lastName) - \(property.login)"
		correctionPoints = "\(property.correctionPoint)"
		if let poolMonth = property.poolMonth, let poolYear = property.poolYear {
			pool = "\(poolMonth) - \(poolYear)"
		}
		location =  property.location ?? property.campus.first?.city ?? "Unknown"
		wallet = "\(property.wallet)"
		phone = property.phone
		imageUrl = property.imageUrl
		email = property.email
		staff = property.staff
		cursuses = property.cursusUsers
	}
}

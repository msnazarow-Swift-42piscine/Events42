//
//  CursusUsersResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

struct CursusUserResponse: Codable {
	let grade: String?
	let level: Float
	let skills: [SkillModel]
	let id: Int
	let cursusId: Int
	let hasCoalition: Bool
	let user: UserShortModel
	let cursus: CursusResponse
}

struct SkillModel: Codable {
	let id: Int
	let name: String
	let level: Float
}

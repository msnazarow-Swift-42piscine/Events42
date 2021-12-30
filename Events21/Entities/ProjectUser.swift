//
//  ProjectUser.swift
//  Events21
//
//  Created by 19733654 on 30.12.2021.
//

import Foundation

struct ProjectUser: Codable {
	let id: Int
	let occurrence: Int
	let finalMark: Int?
	let status: String
	let validated: Bool?
	let currentTeamId: Int?
	let project: ProjectModel
	let cursusIds: [Int]
	let marked: Bool

	enum CodingKeys: String, CodingKey {
		case id
		case occurrence
		case finalMark
		case status
		case validated = "validated?"
		case currentTeamId
		case project
		case cursusIds
		case marked
	}

	struct ProjectModel: Codable {
		let id: Int
		let name: String
		let slug: String
		let parentId: Int?
	}
}

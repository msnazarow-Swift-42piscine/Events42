//
//  AchievementResponse.swift
//  Events21
//
//  Created by 19733654 on 30.12.2021.
//

import Foundation

struct AchievementResponse: Codable {
	let id: Int
	let name: String
	let description: String
	let tier: String
	let kind: String
	let visible: Bool
	let image: URL
	let nbrOfSuccess: Int?
	let usersUrl: URL
}

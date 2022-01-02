//
//  AchievementResponse.swift
//  Events21
//
//  Created by 19733654 on 30.12.2021.
//

import Foundation
import UIKit

struct AchievementResponse: Codable {
	let id: Int
	let name: String
	let description: String
	let tier: Tier
	let kind: String
	let visible: Bool
	let image: URL
	let nbrOfSuccess: Int?
	let usersUrl: URL

	enum Color {
		static let bronze = UIColor(red: 0.58, green: 0.35, blue: 0.13, alpha: 1.00)
		static let silver = UIColor(red: 0.69, green: 0.73, blue: 0.74, alpha: 1.00)
		static let gold = UIColor(red: 0.73, green: 0.68, blue: 0.39, alpha: 1.00)
		static let platin = UIColor(red: 0.79, green: 0.83, blue: 0.84, alpha: 1.00)
	}

	enum Tier: String, Codable {
		case none
		case easy
		case medium
		case hard
		case challenge

		var title: String {
			switch self {
			case .easy: return "Bronze"
			case .medium: return "Silver"
			case .hard: return "Gold"
			case .challenge: return "Platin"
			default: return ""
			}
		}

		var color: UIColor? {
			switch self {
			case .easy: return Color.bronze
			case .medium: return Color.silver
			case .hard: return Color.gold
			case .challenge: return Color.platin
			default: return nil
			}
		}
	}
}

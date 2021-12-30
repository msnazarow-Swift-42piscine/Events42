//
//  UserResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 12.10.2021.
//

import Foundation

struct UserResponse: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let url: URL?
    let login: String
    let createdAt: Date
    let email: String
	let imageUrl: URL?
	let poolMonth: String
	let poolYear: Int
	let staff: Bool
}

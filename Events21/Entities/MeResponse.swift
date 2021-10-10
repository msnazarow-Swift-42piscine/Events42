//
//  MeResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//

import Foundation

struct MeResponse: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let imageUrl: String!
    let login: String
    let cursusUsers: [CursusUsersResponse]
    let campus: [CampusResponse]
}

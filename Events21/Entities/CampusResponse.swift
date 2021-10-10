//
//  CampusResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

struct CampusResponse: Codable {
    let id: Int
    let country: String
    let city: String
    let active: Bool
    let usersCount: Int
    let name: String
    let vogsphereId: Int
}

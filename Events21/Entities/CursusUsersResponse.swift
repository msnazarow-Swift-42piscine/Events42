//
//  CursusUsersResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

struct CursusUsersResponse: Codable {
    let id: Int
    let hasCoalition: Bool
    let cursus: CursusResponse
    let cursusId: Int
    let level: Double
}

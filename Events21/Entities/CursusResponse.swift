//
//  CursusResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

struct CursusResponse: Codable {
    let name: String
    let id: Int
    let slug: String
    let createdAt: Date
}

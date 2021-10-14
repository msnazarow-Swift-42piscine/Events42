//
//  EventResponse.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//

import Foundation

struct EventResponse: Codable {
    let id: Int
    let name: String
    let description: String?
    let maxPeople: Int?
    let nbrSubscribers: Int
    let location: String?
    let kind: String
    let beginAt: Date
    let endAt: Date
    let cursusIds: [Int]
    let campusIds: [Int]
    var duration: String!
}

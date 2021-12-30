//
//  EventUsersResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

struct EventUsersResponse: Codable {
    let event: EventResponse
    let eventId: Int
    let id: Int
    let user: UserShortModel
    let userId: Int
}

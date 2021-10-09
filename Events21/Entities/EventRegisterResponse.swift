//
//  EventRegisterResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

struct EventRegisterResponse: Codable {
    let id: Int
    let userId: Int
    let event: EventResponse
    let user: MeResponse
}

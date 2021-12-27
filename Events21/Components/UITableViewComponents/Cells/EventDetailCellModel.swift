//
//  EventDetailCellModel.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//
//

import Foundation

struct EventDetailCellModel: Identifiable {

    var identifier: String { return "EventDetailCell" }
    
    let name: String
    let description: String?
    let maxPeople: Int?
    let nbrSubscribers: Int?
    let location: String?
    let kind: String
    let beginAt: Date
    let endAt: Date?
    var duration: String?
    let eventId: Int

    init(_ property: EventResponse) {
        name = property.name
        description = property.description
        maxPeople = property.maxPeople
        nbrSubscribers = property.nbrSubscribers
        location = property.location
        kind = property.kind
        beginAt = property.beginAt
        endAt = property.endAt
        eventId = property.id
    }
}

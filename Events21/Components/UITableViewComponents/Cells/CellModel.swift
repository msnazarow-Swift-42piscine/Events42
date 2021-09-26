//
//  CellModel.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//
//

import Foundation

struct Model {

}

struct CellModel: CellIdentifiable {

    var identifier: String { return "Cell" }
    
    let name: String!
    let description: String!
    let maxPeople: Int!
    let nbrSubscribers: Int!
    let location: String!
    let kind: String!
    let beginAt: Date!
    let endAt: Date!

    init(_ property: EventResponse) {
        name = property.name
        description = property.description
        maxPeople = property.maxPeople
        nbrSubscribers = property.nbrSubscribers
        location = property.location
        kind = property.kind
        beginAt = property.beginAt
        endAt = property.endAt
    }
}

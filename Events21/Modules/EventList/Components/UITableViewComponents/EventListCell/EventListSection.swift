//
//  EventListSection.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  

import Foundation

final class EventListSection: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [EventResponse]) {
        properties.forEach { property in
            rows.append(EventListCellModel(property))
        }
    }
}

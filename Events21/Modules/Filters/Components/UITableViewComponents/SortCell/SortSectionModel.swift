//
//  SortSectionModel.swift
//  Events21
//
//  Created by out-nazarov2-ms on 13.10.2021.
//

import Foundation

final class SortSectionModel: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [SortModel]) {
        properties.forEach { property in
            rows.append(SortCellModel(property))
        }
    }
}

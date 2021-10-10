//
//  FilterSectionModel.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//

import Foundation

final class FilterSectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable] = []

    init(_ properties: [FilterModel]) {
        properties.forEach { property in
            rows.append(FilterCellModel(property))
        }
    }
}

//
//  SectionModel.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import Foundation

final class SectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable] = []

    init(_ properties: [Model]) {
        properties.forEach { property in
            rows.append(CellModel(property))
        }
    }
}

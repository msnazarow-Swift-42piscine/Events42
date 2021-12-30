//
//  SearchUserSectionModel.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 28.12.2021.
//  
//

import Foundation

final class SearchUserSection: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [UserShortModel]) {
        properties.forEach {
            rows.append(SearchUserCellModel($0))
        }
    }
}

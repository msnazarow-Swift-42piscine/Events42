//
//  ProjectsSectionModel.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import Foundation

final class ProjectsSectionModel: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [ProjectsModel]) {
        properties.forEach {
            rows.append(ProjectsCellModel($0))
        }
    }
}

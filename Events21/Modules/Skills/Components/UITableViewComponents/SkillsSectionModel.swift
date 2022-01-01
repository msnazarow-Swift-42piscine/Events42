//
//  SkillsSectionModel.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import Foundation

final class SkillsSectionModel: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [SkillsModel]) {
        properties.forEach {
            rows.append(SkillsCellModel($0))
        }
    }
}

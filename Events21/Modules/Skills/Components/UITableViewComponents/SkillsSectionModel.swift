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

    init(_ properties: [SkillModel]) {
        properties.forEach {
            rows.append(SkillCellModel($0))
        }
    }
}

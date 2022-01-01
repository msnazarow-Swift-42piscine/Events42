//
//  AchievementsSectionModel.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import Foundation

final class AchievementsSectionModel: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [AchievementsModel]) {
        properties.forEach {
            rows.append(AchievementsCellModel($0))
        }
    }
}

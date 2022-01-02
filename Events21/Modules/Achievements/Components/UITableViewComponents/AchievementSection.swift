//
//  AchievementSection.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import Foundation

final class AchievementSection: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [AchievementResponse]) {
        properties.forEach {
            rows.append(AchievementCellModel($0))
        }
    }
}

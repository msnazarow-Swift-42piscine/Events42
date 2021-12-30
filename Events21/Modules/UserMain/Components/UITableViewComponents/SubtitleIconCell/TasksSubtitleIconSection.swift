//
//  TasksSubtitleIconSection.swift
//  MainModule
//
//  Created by out-nazarov2-ms on 23.10.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

final class TasksSubtitleIconSection: TableViewSectionProtocol {
    var rows: [Identifiable] = []

    init(_ properties: [SubtitleIconModel]) {
        properties.forEach {
            rows.append(TasksSubtitleIconCellModel($0))
        }
    }
}

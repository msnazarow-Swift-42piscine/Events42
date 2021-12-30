//
//  TasksModuleSubtitleCellModel.swift
//  MainModule
//
//  Created by out-nazarov2-ms on 23.10.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

struct TasksSubtitleIconCellModel: Identifiable {
    var identifier: String = "TasksSubtitleIconCell"
    let title: String
    let subTitle: String
    let icon: String

    init(_ property: SubtitleIconModel) {
        title = property.title
        subTitle = property.subTitle
        icon = property.icon
    }
}

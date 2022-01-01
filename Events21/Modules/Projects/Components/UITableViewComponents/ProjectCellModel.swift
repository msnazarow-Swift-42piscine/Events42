//
//  ProjectCellModel.swift
//  ___MODULENAME___
//
//  Created by out-nazarov2-ms on 23.10.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

struct ProjectCellModel: Identifiable {
    var identifier: String = "ProjectCell"
	let finalMark: Int?
	let status: ProjectUser.Status
	let validated: Bool?
	let name: String

    init(_ property: ProjectUser) {
		name = property.project.name
		finalMark = property.finalMark
		status = property.status
		validated = property.validated
    }
}

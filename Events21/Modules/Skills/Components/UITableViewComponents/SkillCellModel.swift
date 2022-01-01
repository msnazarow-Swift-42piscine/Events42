//
//  InputSubtitleCellModel.swift
//  ___MODULENAME___
//
//  Created by out-nazarov2-ms on 23.10.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

struct SkillCellModel: Identifiable {
    var identifier: String = "SkillCell"
	let name: String
	let level: String
	let progress: Float

    init(_ property: SkillModel) {
		name = property.name
		progress = property.level / 21
		level = "\(property.level)"
    }
}

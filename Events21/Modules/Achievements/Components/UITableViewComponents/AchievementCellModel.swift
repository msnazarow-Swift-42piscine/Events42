//
//  InputSubtitleCellModel.swift
//  ___MODULENAME___
//
//  Created by out-nazarov2-ms on 23.10.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

struct AchievementCellModel: Identifiable {
    var identifier: String = "AchievementCell"
	let name: String
	let description: String
	let tier: AchievementResponse.Tier
	let image: URL

    init(_ property: AchievementResponse) {
		name = property.name
		description = property.description
		tier = property.tier
		image = property.image
    }
}

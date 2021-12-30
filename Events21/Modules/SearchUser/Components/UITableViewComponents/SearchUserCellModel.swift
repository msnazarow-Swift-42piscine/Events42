//
//  InputSubtitleCellModel.swift
//  ___MODULENAME___
//
//  Created by out-nazarov2-ms on 23.10.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

struct SearchUserCellModel: Identifiable {
    var identifier: String = "SearchUserCell"
	let imageUrl: URL
	let login: String
	var pool: String?
	let staff: Bool

    init(_ property: UserShortModel) {
		imageUrl = property.imageUrl
		login = property.login
		if let month = property.poolMonth, let year = property.poolYear {
			pool = "Poll at \(month) \(year)"
		}
		staff = property.staff ?? false
    }
}

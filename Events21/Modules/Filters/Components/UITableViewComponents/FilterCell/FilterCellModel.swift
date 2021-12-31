//
//  FilterCellModel.swift
//  Events21
//
//  Created by 19733654 on 31.12.2021.
//

import Foundation

struct FilterCellModel: Identifiable {
	let identifier = "FilterCell"
	let name: String
	let value: Bool

	init(_ property: FilterModel) {
		name = property.name
		value = property.value
	}
}

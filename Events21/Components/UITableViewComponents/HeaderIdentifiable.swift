//
//  HeaderIdentifiable.swift
//  Events21
//
//  Created by 19733654 on 31.12.2021.
//

import UIKit

class HeaderIdentifiable: UITableViewHeaderFooterView, ModelRepresentable {
	weak var presenter: AnyObject?

	var model: Identifiable? {
		didSet {
			updateViews()
		}
	}

	func updateViews() {}
}

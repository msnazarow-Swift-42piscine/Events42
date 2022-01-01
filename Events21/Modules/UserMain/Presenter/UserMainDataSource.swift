//
//  UserMainDataSource.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit

class UserMainDataSource: NSObject, PresenterToDataSourceUserMainProtocol {

    // MARK: Properties
    weak var presenter: CellToPresenterUserMainProtocol?

    private var sections: [TableViewSectionProtocol] = []
	private var headers: [Identifiable] = []

    func updateForSections(_ sections: [TableViewSectionProtocol]) {
        self.sections = sections
    }

	func updateForHeader(_ headers: [Identifiable]) {
		self.headers = headers
	}

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.identifier, for: indexPath) as? CellIdentifiable else {
            return UITableViewCell()
        }
        cell.presenter = presenter
        cell.model = model
        return cell
    }
}

extension UserMainDataSource {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerModel = headers[section]
		let tableViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerModel.identifier)
		guard let header = tableViewHeader as? HeaderIdentifiable else {
			return tableViewHeader
		}
		header.model = headerModel
		header.presenter = presenter
		return header
	}
}

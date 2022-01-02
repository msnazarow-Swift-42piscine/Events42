//
//  SearchUserDataSource.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//  
//

import UIKit

class SearchUserDataSource: NSObject, PresenterToDataSourceSearchUserProtocol {

    // MARK: Properties
    weak var presenter: CellToPresenterSearchUserProtocol?

    private var sections: [TableViewSectionProtocol] = []

    func updateForSections(_ sections: [TableViewSectionProtocol]) {
        self.sections = sections
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

extension SearchUserDataSource {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let presenter = presenter as? CellToPresenterSearchUserProtocol,
			  let model = sections[indexPath.section].rows[indexPath.row] as? SearchUserCellModel
			  else { return }

		presenter.didSelectUser(userId: model.userId)
	}
}

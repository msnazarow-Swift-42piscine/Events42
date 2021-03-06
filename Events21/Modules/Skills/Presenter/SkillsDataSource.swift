//
//  SkillsDataSource.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class SkillsDataSource: NSObject, PresenterToDataSourceSkillsProtocol {
    // MARK: Properties
    weak var presenter: CellToPresenterSkillsProtocol?

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

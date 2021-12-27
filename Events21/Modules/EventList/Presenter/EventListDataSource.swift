//
//  EventListDataSource.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

class EventListDataSource: NSObject, PresenterToDataSourceUserProtocol {

    // MARK: Properties
    weak var presenter: CellToPresenterUserProtocol!

    private var sections: [EventDetailSectionModel] = []

    func updateForSections(_ sections: [EventDetailSectionModel]) {
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
//        cell.presenter = presenter
        cell.model = model
        return cell
    }
}

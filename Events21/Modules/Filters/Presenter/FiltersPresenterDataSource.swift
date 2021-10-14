//
//  FiltersPresenterDataSource.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit

class FiltersPresenterDataSource: NSObject, PresenterToDataSourceFiltersProtocol {
    // MARK: Properties
    weak var presenter: CellToPresenterFiltersProtocol!

    private var sections: [SectionRowsRepresentable] = []
    var sortSelect: [String?] = [.none, .type, .campus, .syllabus]
    var order: [String] = [.inc, .dec]
    var selectedSort: Int = 0
    var selectedOrder: Int = 0
    var temporarySortSelect: String!

    func updateForSections(_ sections: [SectionRowsRepresentable]) {
        self.sections = sections
    }

    func addTemporarySortSelect(_ string: String) {
        self.temporarySortSelect = string
        sortSelect.append(temporarySortSelect)
    }

    func removeTemporarySortSelect() {
        guard let temporarySortSelect = temporarySortSelect else { return }
        if let index = sortSelect.firstIndex(of: temporarySortSelect) {
            sortSelect.remove(at: index)
        }
        self.selectedSort = 0
        self.temporarySortSelect = nil
    }

    func appendSortSelect(_ strings: [String?]) {
        sortSelect.append(contentsOf: strings)
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.identifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.presenter = presenter
        cell.model = model
        return cell
    }
}

extension FiltersPresenterDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return sortSelect .count
        } else {
            return order.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return sortSelect[row]
        } else {
            return order[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            return selectedSort = row
        } else {
            return selectedOrder = row
        }
    }
}


extension FiltersPresenterDataSource {

    func didTapDone() {
        if let sort = sortSelect[selectedSort] {
            presenter.setTextField("\(sort) \(order[selectedOrder])")
        } else {
            presenter.setTextField("")
        }
        if selectedSort > 0 {
            sortSelect.remove(at: selectedSort)
        }
        presenter.selectPicker(at: 0)
        selectedSort = 0
    }

    func didTapCancel() {
        presenter.textFieldResignFirstResponder()
    }
}

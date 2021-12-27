//
//  EventListFiltersView.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit

class EventListFiltersView: UITableViewController {
    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 40 * verticalTranslation))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30 * verticalTranslation)
        label.textAlignment = .center
        label.text = "Filters"
        return label
    }()

    lazy var header: UITableViewHeaderFooterView = {
        let header = UITableViewHeaderFooterView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(label)
        return header
    }()

    let pickerView: ToolbarPickerView = {
        let pickerView = ToolbarPickerView()
        return pickerView
    }()

    // MARK: - Properties
    var presenter: ViewToPresenterFiltersProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    override func viewDidDisappear(_ animated: Bool) {
        presenter.viewDidDisappear()
    }

    private func setupUI() {
        addSubviews()
        setupConstraints()
        tableView.register(FilterCell.self)
        tableView.register(SortCell.self)
        tableView.dataSource = presenter.dataSource
        pickerView.dataSource = presenter.dataSource
        pickerView.delegate = presenter.dataSource
        pickerView.toolbarDelegate = presenter.dataSource
    }

    private func addSubviews() {
        tableView.allowsSelection = false
        tableView.tableHeaderView =  label
        tableView.estimatedSectionHeaderHeight = 40 * verticalTranslation
        tableView.sectionHeaderHeight = 40 * verticalTranslation
        tableView.bounces  = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: tableView.layoutMarginsGuide.topAnchor,constant: 10),
            label.leadingAnchor.constraint(equalTo: tableView.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: tableView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

extension EventListFiltersView: PresenterToViewFiltersProtocol{
    func updateSortItem(_ number: Int) {
        tableView.reloadRows(at: [IndexPath(row: number, section: 1)], with: .automatic)
    }

    func insertRow(at indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    func removeRows(after indexPath: IndexPath, number: Int) {
        tableView.deleteRows(at: Array(indexPath.row ... indexPath.row + number - 1).map{ IndexPath(row: $0, section: indexPath.section)}, with: .automatic)
    }

    func selectPicker(at row: Int) {
        pickerView.selectRow(row, inComponent: 0, animated: true)
    }

    func reloadPickerView() {
        pickerView.reloadAllComponents()
    }
}



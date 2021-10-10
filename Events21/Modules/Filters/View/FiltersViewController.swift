//
//  FiltersViewController.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import UIKit

class FiltersViewController: UITableViewController {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30 * verticalTranslation)
        label.textAlignment = .center
        label.text = "Filters"
        return label
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
        tableView.dataSource = presenter.dataSource
    }

    private func addSubviews() {
        tableView.tableHeaderView = label
        tableView.estimatedSectionHeaderHeight = 40 * verticalTranslation
        tableView.bounces  = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: tableView.layoutMarginsGuide.topAnchor,constant: 10),
            label.widthAnchor.constraint(equalTo: tableView.layoutMarginsGuide.widthAnchor)
        ])
    }
}

extension FiltersViewController: PresenterToViewFiltersProtocol{
    
}

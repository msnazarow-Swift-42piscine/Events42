//
//  SearchUserViewController.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//  
//

import UIKit

class SearchUserViewController: UIViewController {
    // MARK: - Properties
    var presenter: ViewToPresenterSearchUserProtocol!

	lazy var searchController: UISearchController = {
		let sc = UISearchController(searchResultsController: nil)
		sc.searchResultsUpdater = self
		sc.obscuresBackgroundDuringPresentation = false
		sc.searchBar.placeholder = "Search intra users"
		return sc
	}()

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(SearchUserCell.self)
		tableView.delegate = presenter.dataSource
		tableView.dataSource = presenter.dataSource
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
		return tableView
	}()

    // MARK: - Init
    convenience init(presenter: ViewToPresenterSearchUserProtocol) {
        self.init()
        self.presenter = presenter
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }

    private func setupUI() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		navigationItem.searchController = searchController
		definesPresentationContext = true
//		navigationItem.searchController?.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
		view.addSubview(tableView)
    }

    private func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
    }
}

extension SearchUserViewController: PresenterToViewSearchUserProtocol {
	func tableViewReload() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}

extension SearchUserViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		presenter.updateSearchResults(searchController.searchBar.text)
	}
}

extension SearchUserViewController: UITableViewDelegate {
}

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
		navigationItem.searchController?.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {

    }

    private func setupConstraints() {

    }
}

extension SearchUserViewController: PresenterToViewSearchUserProtocol {
    
}

extension SearchUserViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		presenter.updateSearchResults(searchController.searchBar.text)
		
	}
}

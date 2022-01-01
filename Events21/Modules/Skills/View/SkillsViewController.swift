//
//  SkillsViewController.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class SkillsViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterSkillsProtocol!

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(SkillCell.self)
		tableView.dataSource = presenter.dataSource
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()

    // MARK: - Init
    convenience init(presenter: ViewToPresenterSkillsProtocol) {
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
		title = "Skills"
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

extension SkillsViewController: PresenterToViewSkillsProtocol {
	func tableViewReload() {
		tableView.reloadData()
	}
}

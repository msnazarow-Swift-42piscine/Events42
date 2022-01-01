//
//  ProjectsViewController.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class ProjectsViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterProjectsProtocol!

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(ProjectCell.self)
		tableView.backgroundColor = .clear
		tableView.dataSource = presenter.dataSource
		tableView.delegate = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .singleLine
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()

    // MARK: - Init
    convenience init(presenter: ViewToPresenterProjectsProtocol) {
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
		title = "Projects"
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
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

extension ProjectsViewController: PresenterToViewProjectsProtocol {
    
}

extension ProjectsViewController: UITableViewDelegate {
	
}

//
//  AchievementsViewController.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class AchievementsViewController: UIViewController {
    // MARK: - Properties
    var presenter: ViewToPresenterAchievementsProtocol!
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(AchievementCell.self)
		tableView.dataSource = presenter.dataSource
		tableView.allowsSelection = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
		return tableView
	}()

    // MARK: - Init
    convenience init(presenter: ViewToPresenterAchievementsProtocol) {
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
		title = "Achievements"
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

extension AchievementsViewController: PresenterToViewAchievementsProtocol {
	func tableViewReload() {
		tableView.reloadData()
	}
}

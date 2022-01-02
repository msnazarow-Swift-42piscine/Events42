//
//  EventListView.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

// TODO: Сверстать основной экран с инфой о пользователе и табличкой евентов - по клике на ивент - в отдельном вью через navigation (можно через popup) доп инфа Event модуль


class EventListView: UIViewController {
    // MARK: - Views
	lazy var filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .done, target: self, action: #selector(filtersButtonTapped))

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = .clear
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = presenter?.dataSource
		tableView.delegate = self
		tableView.register(EventListCell.self, forCellReuseIdentifier: String(describing: EventListCell.self))
		return tableView
	}()

    // MARK: - Properties
    var presenter: ViewToPresenterUserProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        presenter.viewWillAppear()
//    }

    private func setupUI() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		setupNavigationController()
		addSubviews()
        setupConstraints()
    }

	private func setupNavigationController() {
		navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "background")!)
		navigationItem.rightBarButtonItem = filterButton
	}

    private func addSubviews() {
		view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

	@objc func filtersButtonTapped() {
		presenter.filtersButtonTapped()
	}
}

extension EventListView: PresenterToViewUserProtocol {
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showAlert(title: String, message: String, completion: (() -> Void)?) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: completion)
        }
    }
}

extension EventListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(modelId: indexPath.row)
    }
//
//	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        filterButton
//    }

}

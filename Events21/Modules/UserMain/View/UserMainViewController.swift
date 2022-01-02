//
//  UserMainViewController.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit

class UserMainViewController: UIViewController {
    // MARK: - Properties
    var presenter: ViewToPresenterUserMainProtocol!

	// MARK: - Views
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: CGRect(), style: .grouped)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(UserHeader.self)
		tableView.register(TasksSubtitleIconCell.self)
		tableView.delegate = presenter.dataSource
		tableView.dataSource = presenter.dataSource
		tableView.backgroundColor = .clear
		return tableView
	}()

	lazy var logOutButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right.square"), style: .done, target: self, action: #selector(logoutButtonTapped))

	// MARK: - Init
    convenience init(presenter: ViewToPresenterUserMainProtocol) {
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
		navigationItem.rightBarButtonItem = logOutButton
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
		view.addSubview(tableView)
//		view.addSubview(horizontalStackView)
    }

    private func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.leftAnchor.constraint(equalTo: tableView.superview!.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: tableView.superview!.rightAnchor),
			tableView.topAnchor.constraint(equalTo: tableView.superview!.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: tableView.superview!.bottomAnchor)
		])
    }
}

extension UserMainViewController: PresenterToViewUserMainProtocol {
//	func setProfileImageView(image: UIImage)  {
//		DispatchQueue.main.async {
//			self.profileImageView.image = image
//		}
//	}
//
//	func setLogin(_ login: String) {
//		DispatchQueue.main.async {
//			self.loginLabel.text = login
//		}
//	}
//
//	func setName(_ name: String) {
//		DispatchQueue.main.async {
//			self.nameLabel.text = name
//		}
//	}
//
//	func setSurname(_ surname: String) {
//		DispatchQueue.main.async {
//			self.surnameLabel.text = surname
//		}
//	}
//
//	func setLevel(_ level: String) {
//		DispatchQueue.main.async {
//			self.levelTextView.text = level
//		}
//	}

	func showAlert(title: String, message: String, completion: (() -> Void)?) {
		DispatchQueue.main.async { [self] in
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
			present(alert, animated: true, completion: completion)
		}
	}

	func showAlertQuestion(title: String, message: String, completion: (() -> Void)?) {
		DispatchQueue.main.async { [self] in
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in completion?() })
			alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
			present(alert, animated: true)
		}
	}

	func tableViewReload() {
		tableView.reloadData()
	}

	@objc func logoutButtonTapped() {
		presenter.logoutButtonTapped()
	}
}

extension UserMainViewController: UITableViewDelegate {
}

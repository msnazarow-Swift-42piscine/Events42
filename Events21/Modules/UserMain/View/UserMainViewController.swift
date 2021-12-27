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
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 150 * verticalTranslation).isActive = true
		return imageView
	}()

	let loginLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldSystemFont(ofSize: 15 * verticalTranslation)
		label.textAlignment = .left
		return label
	}()

	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		return label
	}()

	let surnameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		return label
	}()

	let levelTextView: UITextView = {
		let textView = UITextView()
		textView.isEditable = false
		textView.backgroundColor = .clear
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = .systemFont(ofSize: 14 * verticalTranslation)
		return textView
	}()

	lazy var verticalStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [loginLabel, nameLabel, surnameLabel, levelTextView])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 8
		stackView.axis = .vertical
		return stackView
	}()

	lazy var horizontalStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [profileImageView, verticalStackView])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.spacing = 10
		return stackView
	}()

	lazy var logOutButton = UIBarButtonItem(title: .logOut, style: .done, target: self, action: #selector(logoutButtonTapped))

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
		tabBarController?.navigationController?.navigationBar.isHidden = true
		navigationItem.rightBarButtonItem = logOutButton
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
		view.addSubview(horizontalStackView)
    }

    private func setupConstraints() {
		NSLayoutConstraint.activate([
			horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])
    }
}

extension UserMainViewController: PresenterToViewUserMainProtocol {
	func setProfileImageView(image: UIImage)  {
		DispatchQueue.main.async {
			self.profileImageView.image = image
		}
	}

	func setLogin(_ login: String) {
		DispatchQueue.main.async {
			self.loginLabel.text = login
		}
	}

	func setName(_ name: String) {
		DispatchQueue.main.async {
			self.nameLabel.text = name
		}
	}

	func setSurname(_ surname: String) {
		DispatchQueue.main.async {
			self.surnameLabel.text = surname
		}
	}

	func setLevel(_ level: String) {
		DispatchQueue.main.async {
			self.levelTextView.text = level
		}
	}

	func showAlert(title: String, message: String, completion: (() -> Void)?) {
		DispatchQueue.main.async { [self] in
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
			present(alert, animated: true, completion: completion)
		}
	}

	@objc func logoutButtonTapped() {
		presenter.logoutButtonTapped()
	}

}

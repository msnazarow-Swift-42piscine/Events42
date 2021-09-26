//
//  UserViewController.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

//TODO: Сверстать основной экран с инфой о пользователе и табличкой евентов - по клике на ивент - в отдельном вью через navigation (можно через popup) доп инфа Event модуль


class UserViewController: UIViewController {
    
    // MARK: - UI
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
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    let surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        // remove after test
//        label.text = "Bulwer"
        return label
    }()
    
    let levelTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 14)
        textView.text = "Current level: 9.88"
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
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    // MARK: - Properties
    var presenter: ViewToPresenterUserProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        addSubviews()
        tableView.dataSource = presenter?.dataSource
//        tableView.delegate = self
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(horizontalStackView)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        view.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension UserViewController: PresenterToViewUserProtocol{
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
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

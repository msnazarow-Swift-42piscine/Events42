//
//  UserViewController.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

//TODO: Сверстать основной экран с инфой о пользователе и табличкой евентов - по клике на ивент - в отдельном вью через navigation (можно через popup) доп инфа Event модуль


class UserViewController: UITableViewController {
    
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

    let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.setTitle(.filters, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tag = 1
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    var presenter: ViewToPresenterUserProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }

    private func setupUI() {
        addSubviews()
        tableView.dataSource = presenter?.dataSource
        tableView.delegate = self
        tableView.register(EventCell.self, forCellReuseIdentifier: String(describing: EventCell.self))
        setupConstraints()
    }

    private func addSubviews() {
        let item = UIBarButtonItem(title: .logOut, style: .plain, target: self, action: #selector(buttonDidTapped))
        item.tag = 1
        navigationItem.rightBarButtonItem = item
        tableView.tableHeaderView = horizontalStackView
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: tableView.layoutMarginsGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: tableView.layoutMarginsGuide.trailingAnchor),
        ])
    }

    @objc func buttonDidTapped(_ sender: AnyObject) {
        if let sender = sender as? UIButton {
            presenter.buttonDidTapped(sender.currentTitle ?? "")
        } else if let sender = sender as? UIBarButtonItem {
            presenter.buttonDidTapped(sender.title ?? "")
        }
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

extension UserViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(modelId: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        filterButton
    }

}

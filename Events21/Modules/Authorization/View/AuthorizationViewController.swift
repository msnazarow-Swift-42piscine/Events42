//
//  AuthorizationViewController.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

//TODO: Авторизация пользователя, webView? 


import UIKit
import WebKit
class AuthorizationViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterAuthorizationProtocol!
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20 * verticalTranslation)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor.cyan.cgColor
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc private func didTapLoginButton() {
        presenter.didTapLoginButton()
    }
}

extension AuthorizationViewController: PresenterToViewAuthorizationProtocol{
    
}

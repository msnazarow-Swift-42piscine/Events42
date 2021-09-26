//
//  AuthorizationViewController.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

//TODO: Авторизация пользователя, webview? 


import UIKit

class AuthorizationViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterAuthorizationProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {

    }

    private func setupConstraints() {

    }
}

extension AuthorizationViewController: PresenterToViewAuthorizationProtocol{
    
}

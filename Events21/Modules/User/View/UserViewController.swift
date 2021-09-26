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
        setupConstraints()
    }

    private func addSubviews() {

    }

    private func setupConstraints() {

    }
}

extension UserViewController: PresenterToViewUserProtocol{
    
}

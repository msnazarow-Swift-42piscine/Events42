//
//  SkillsViewController.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class SkillsViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterSkillsProtocol!


    // MARK: - Init
    convenience init(presenter: ViewToPresenterSkillsProtocol) {
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
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {

    }

    private func setupConstraints() {

    }
}

extension SkillsViewController: PresenterToViewSkillsProtocol {
    
}

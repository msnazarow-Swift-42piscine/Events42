//
//  ProjectsViewController.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class ProjectsViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterProjectsProtocol!


    // MARK: - Init
    convenience init(presenter: ViewToPresenterProjectsProtocol) {
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

extension ProjectsViewController: PresenterToViewProjectsProtocol {
    
}

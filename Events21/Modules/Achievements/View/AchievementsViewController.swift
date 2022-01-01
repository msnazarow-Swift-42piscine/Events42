//
//  AchievementsViewController.swift
//  Events21
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class AchievementsViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterAchievementsProtocol!


    // MARK: - Init
    convenience init(presenter: ViewToPresenterAchievementsProtocol) {
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
		title = "Achievements"
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {

    }

    private func setupConstraints() {

    }
}

extension AchievementsViewController: PresenterToViewAchievementsProtocol {
    
}

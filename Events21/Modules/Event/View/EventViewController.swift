//
//  EventViewController.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

//TODO: Инфа по ивенту + кнопка зарегистирроваться/отрегестрироваться


import UIKit

class EventViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterEventProtocol!

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

extension EventViewController: PresenterToViewEventProtocol{
    
}

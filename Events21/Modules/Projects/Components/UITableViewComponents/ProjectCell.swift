//
//  ProjectCell.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class ProjectCell: CellIdentifiable {
	let gap: CGFloat = 10

	private lazy var projectNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.textColor = .white
		return label
	}()

	private lazy var projectValidatedImage: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private lazy var projectMarkLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		return label
	}()

	private lazy var view: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupUI() {
		selectionStyle = .none
		backgroundColor = .clear
		addSubviews()
		setupConstraints()
	}

	func addSubviews() {
		contentView.addSubview(view)
		view.addSubview(projectNameLabel)
		view.addSubview(projectMarkLabel)
		view.addSubview(projectValidatedImage)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate(
			[
				view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
				view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap),
				view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: gap),
				view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -gap),

				projectNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
				projectNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				projectNameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
				projectNameLabel.trailingAnchor.constraint(equalTo: projectValidatedImage.leadingAnchor, constant: -gap),

				projectMarkLabel.topAnchor.constraint(equalTo: view.topAnchor),
				projectMarkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				projectMarkLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),

				projectValidatedImage.heightAnchor.constraint(equalToConstant: 21),
				projectValidatedImage.widthAnchor.constraint(equalToConstant: 21),
				projectValidatedImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
				projectValidatedImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
			]
		)
	}

    override func updateViews() {
        guard let model = model as? ProjectCellModel else { return }
		projectNameLabel.text = model.name
		projectMarkLabel.text = "\(model.finalMark ?? 0)"
		if let validated = model.validated, validated {
			projectValidatedImage.image = UIImage(named: "success")
		} else {
			projectValidatedImage.image = UIImage(named: "fail")
		}
    }
}

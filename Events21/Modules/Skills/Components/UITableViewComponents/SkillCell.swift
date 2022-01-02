//
//  SkillCell.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class SkillCell: CellIdentifiable {
	let gap: CGFloat = 10

	private lazy var skillNameLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		return label
	}()

	private lazy var skillValueLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .right
		label.textColor = .white
		return label
	}()

	private lazy var skillsProgressView: UIProgressView = {
		let view = UIProgressView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.trackTintColor = UIColor(red: 0.13, green: 0.13, blue: 0.15, alpha: 0.50)
		view.progressTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.74, alpha: 1.00)
		return view
	}()

	private lazy var hStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [skillNameLabel, skillValueLabel])
		stack.axis = .horizontal
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	private lazy var view: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		selectionStyle = .none
	}

	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupUI() {
		backgroundColor = .clear
		addSubviews()
		setupConstraints()
	}

	func addSubviews() {
		contentView.addSubview(view)
		view.addSubview(hStack)
		view.addSubview(skillsProgressView)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate(
			[
				view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: gap),
				view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
				view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap),
				view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -gap),

				hStack.topAnchor.constraint(equalTo: view.topAnchor),
				hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),

				skillsProgressView.heightAnchor.constraint(equalToConstant: 5),
				skillsProgressView.topAnchor.constraint(equalTo: hStack.bottomAnchor),
				skillsProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				skillsProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				skillsProgressView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			]
		)
	}

	override func updateViews() {
		guard let model = model as? SkillCellModel else { return }
		skillNameLabel.text = model.name
		skillsProgressView.progress = model.progress
		skillValueLabel.text = model.level
	}
}

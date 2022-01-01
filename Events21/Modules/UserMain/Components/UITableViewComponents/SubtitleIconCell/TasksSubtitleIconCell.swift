//
//  TasksSubtitleIconCell.swift
//  MainModule
//
//  Created by out-nazarov2-ms on 23.10.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class TasksSubtitleIconCell: CellIdentifiable {
    // MARK: - Constants
    private enum Offset {
        static let top: CGFloat = 12
        static let bottom: CGFloat = 12
        static let left: CGFloat = 16
        static let right: CGFloat = 16
        static let iconWidth: CGFloat = 24
        static let iconContainerWidth: CGFloat = 40
    }

    // MARK: - Views
    let nameField: UILabel = {
        let label = UILabel()
//        label.attributedFont = .subtitle1
        label.numberOfLines = 0
		label.textColor = .white
//		label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

	let valueField: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.numberOfLines = 0
		return label
	}()

    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField, valueField])
        stack.axis = .vertical
        return stack
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [vStack, iconView])
		stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()

    private lazy var iconView: UIView = {
        let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let icon: UIImageView = {
        let image = UIImageView()
		image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.contentScaleFactor = 1
		image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupUI
    func setupUI() {
		selectionStyle = .none
		backgroundColor = .clear
        addSubviews()
        setupConstraints()
    }
    private func addSubviews() {
        contentView.addSubview(hStack)
		iconView.addSubview(icon)
    }

    private func setupConstraints() {
		NSLayoutConstraint.activate([
			iconView.widthAnchor.constraint(equalToConstant: Offset.iconContainerWidth),

			icon.widthAnchor.constraint(equalToConstant: Offset.iconWidth),
			icon.heightAnchor.constraint(equalToConstant: Offset.iconWidth),
			icon.centerXAnchor.constraint(equalTo: icon.superview!.centerXAnchor),
			icon.centerYAnchor.constraint(equalTo: icon.superview!.centerYAnchor),

			hStack.leftAnchor.constraint(equalTo: hStack.superview!.leftAnchor, constant: Offset.left),
			hStack.rightAnchor.constraint(equalTo: hStack.superview!.rightAnchor, constant: -Offset.right),
			hStack.topAnchor.constraint(equalTo: hStack.superview!.topAnchor, constant: Offset.top),
			hStack.bottomAnchor.constraint(equalTo: hStack.superview!.bottomAnchor, constant: -Offset.bottom)
		])
    }

    // MARK: - UpdateViews
    override func updateViews() {
        guard let model = model as? TasksSubtitleIconCellModel else { return }
        nameField.text = model.title
        valueField.text = model.subTitle
		icon.image = UIImage(systemName: model.icon)!
    }
}

//
//  AchievementCell.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class AchievementCell: CellIdentifiable {
	let gap: CGFloat = 10

	private let iconView: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		view.widthAnchor.constraint(equalToConstant: 100).isActive = true
		view.heightAnchor.constraint(equalToConstant: 100).isActive = true
		return view
	}()

	private let tierLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.layer.cornerRadius = 10
		label.textAlignment = .center
		label.clipsToBounds = true
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 20 * verticalTranslation)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let view: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	func setupUI() {
		backgroundColor = .clear
		addSubviews()
		setupConstraints()
	}

	func addSubviews() {
		view.addSubview(iconView)
		view.addSubview(nameLabel)
		view.addSubview(descriptionLabel)
		view.addSubview(tierLabel)
		contentView.addSubview(view)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: gap),
			view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -gap),
			view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
			view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap),

			iconView.leftAnchor.constraint(equalTo: iconView.superview!.leftAnchor),
			iconView.topAnchor.constraint(equalTo: iconView.superview!.topAnchor),
			iconView.bottomAnchor.constraint(equalTo: tierLabel.topAnchor),

			tierLabel.leftAnchor.constraint(equalTo: tierLabel.superview!.leftAnchor),
			tierLabel.rightAnchor.constraint(equalTo: iconView.rightAnchor),
			tierLabel.bottomAnchor.constraint(equalTo: iconView.superview!.bottomAnchor),

			nameLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: gap),
			nameLabel.rightAnchor.constraint(equalTo: nameLabel.superview!.rightAnchor),
			nameLabel.topAnchor.constraint(equalTo: nameLabel.superview!.topAnchor),
			nameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),

			descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
			descriptionLabel.rightAnchor.constraint(equalTo: descriptionLabel.superview!.rightAnchor),
			descriptionLabel.bottomAnchor.constraint(equalTo: descriptionLabel.superview!.bottomAnchor),
		])
	}

    override func updateViews() {
        guard let model = model as? AchievementCellModel else { return }
		nameLabel.text = model.name
		descriptionLabel.text = model.description
		tierLabel.text = model.tier.title
		tierLabel.backgroundColor = model.tier.color
		ImageCashingService.shared.getImage(for: URL(string: "https://api.intra.42.fr" + model.image.path)!) { [weak self] image in
			DispatchQueue.main.async {
				self?.iconView.image = image
			}
		}
    }
}

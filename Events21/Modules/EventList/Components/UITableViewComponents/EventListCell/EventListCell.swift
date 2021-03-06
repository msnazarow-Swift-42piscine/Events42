//
//  EventListCell.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//

import UIKit

class EventListCell: CellIdentifiable {
    // MARK: - Views
    let eventTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24 * verticalTranslation)
        label.textColor = .cyan
        label.textAlignment = .left
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
		label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14 * verticalTranslation)
        return label
    }()

    let dateEventLabel: UILabel = {
        let label = UILabel()
		label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20 * verticalTranslation)
        label.textAlignment = .left
        return label
    }()

    let durationTimeLabel: UILabel = {
        let label = UILabel()
		label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20 * verticalTranslation)
        label.textAlignment = .right
        return label
    }()

    lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [dateEventLabel, durationTimeLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        return sv
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
		selectionStyle = .none
		addSubviews()
		setupConstraints()
	}

	func addSubviews() {
		contentView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		contentView.addSubview(eventTitleLabel)
		contentView.addSubview(nameLabel)
		contentView.addSubview(bottomStackView)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			eventTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			eventTitleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			eventTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),

			nameLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 10),
			nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

			bottomStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
			bottomStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			bottomStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			bottomStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
		])
	}

    override func updateViews() {
        guard let model = model as? EventListCellModel else { return }
        nameLabel.text = model.name
        eventTitleLabel.text = model.kind
        dateEventLabel.text = model.beginAt.dateSlashString
        durationTimeLabel.text = model.duration
    }
}

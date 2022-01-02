//
//  SearchUserCell.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 28.12.2021.
//  
//

import UIKit

class SearchUserCell: CellIdentifiable {
	let gap: CGFloat = 10

	let profileImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		return imageView
	}()

	let login: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let pool: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let staff: UILabel = {
		let label = UILabel()
		label.backgroundColor = .red
		label.textColor = .white
		label.layer.cornerRadius = 5
		label.clipsToBounds = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
    }

	func setupUI() {
		addSubviews()
		setupConstraints()
	}

	func addSubviews() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubview(staff)
		contentView.addSubview(profileImage)
		contentView.addSubview(login)
		contentView.addSubview(pool)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: gap),
			profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
			profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap),

			login.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: gap),
			login.topAnchor.constraint(equalTo: profileImage.topAnchor),

			staff.leftAnchor.constraint(equalTo: login.rightAnchor, constant: gap),
			staff.topAnchor.constraint(equalTo: login.topAnchor),

			pool.topAnchor.constraint(equalTo: login.bottomAnchor, constant: gap),
			pool.leftAnchor.constraint(equalTo: login.leftAnchor)
		])
	}

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? SearchUserCellModel else { return }
		login.text = model.login
		pool.text = model.pool
		staff.text = model.staff ? "STAFF" : ""
		ImageCashingService.shared.getImage(for: model.imageUrl) { [weak self] image in
			DispatchQueue.main.async {
				self?.profileImage.image = image
			}
		}
    }
}

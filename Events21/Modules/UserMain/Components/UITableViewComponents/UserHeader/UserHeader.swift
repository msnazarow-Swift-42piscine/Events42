//
//  UserHeader.swift
//  Events21
//
//  Created by 19733654 on 30.12.2021.
//

import UIKit

class UserHeader: UITableViewHeaderFooterView {
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 150 * verticalTranslation).isActive = true
		return imageView
	}()

	let loginLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldSystemFont(ofSize: 15 * verticalTranslation)
		label.textAlignment = .left
		return label
	}()

	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		return label
	}()

	let surnameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		return label
	}()

	let levelTextView: UITextView = {
		let textView = UITextView()
		textView.isEditable = false
		textView.backgroundColor = .clear
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = .systemFont(ofSize: 14 * verticalTranslation)
		return textView
	}()
}

//
//  UserHeader.swift
//  Events21
//
//  Created by 19733654 on 30.12.2021.
//

import UIKit

class UserHeader: HeaderIdentifiable {
	let gap: CGFloat = 10

	var cursusUser: CursusUserResponse?
	var chosenIndex: Int?

	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 20
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 100 * verticalTranslation).isActive = true
		return imageView
	}()

	let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldSystemFont(ofSize: 18 * verticalTranslation)
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()

	let walletLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		label.textColor = .white
		return label
	}()

	let correctionPointsLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		label.textColor = .white
		return label
	}()

	let locationLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		label.textColor = .white
		return label
	}()

	let phoneLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		label.textColor = .white
		return label
	}()

	let emailLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		label.textColor = .white
		return label
	}()


	let poolLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.textAlignment = .left
		label.textColor = .white
		return label
	}()

	let staffLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14 * verticalTranslation)
		label.backgroundColor = UIColor.red.withAlphaComponent(0.7)
		label.text = "STAFF"
		label.textColor = .white
		label.layer.cornerRadius = 10
		label.textAlignment = .left
		return label
	}()

	lazy var rightStack: UIStackView = {
		let stackView = UIStackView(
			arrangedSubviews: [walletLabel, correctionPointsLabel, phoneLabel, emailLabel, locationLabel]
		)
		stackView.alignment = .leading
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 8
		stackView.axis = .vertical
		return stackView
	}()

	lazy var bottomStack: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [phoneLabel, emailLabel, locationLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 8
		return stackView
	}()

	lazy var cursusView: UITextField = {
		let view = UITextField()
		view.textColor = .white
		view.textAlignment = .center
		view.translatesAutoresizingMaskIntoConstraints = false
		view.inputView = pickerView
		view.inputAccessoryView = pickerView.toolbar
		view.isHidden = true
		return view
	}()

	lazy var pickerView: ToolbarPickerView = {
		let view = ToolbarPickerView()
		view.toolbarDelegate = self
		view.translatesAutoresizingMaskIntoConstraints = false
		view.dataSource = self
		view.delegate = self
		return view
	}()

	let levelView: UserProfileProgressView = {
		let view = UserProfileProgressView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupUI() {
		addSubviews()
		setupConstraints()
	}

	func addSubviews() {
		contentView.addSubview(profileImageView)
		contentView.addSubview(nameLabel)
		contentView.addSubview(rightStack)
		contentView.addSubview(bottomStack)
		contentView.addSubview(cursusView)
		contentView.addSubview(levelView)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),

			profileImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: gap),
			profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: gap),
			profileImageView.rightAnchor.constraint(equalTo: rightStack.leftAnchor, constant: -gap),

			rightStack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
			rightStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -gap),

			bottomStack.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: gap),
			bottomStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: gap),

			cursusView.leftAnchor.constraint(equalTo: profileImageView.leftAnchor),
			cursusView.rightAnchor.constraint(equalTo: rightStack.rightAnchor),
			cursusView.topAnchor.constraint(equalTo: bottomStack.bottomAnchor, constant: gap),
			cursusView.bottomAnchor.constraint(equalTo: levelView.topAnchor, constant: -gap),

			levelView.leftAnchor.constraint(equalTo: cursusView.leftAnchor),
			levelView.rightAnchor.constraint(equalTo: cursusView.rightAnchor),
			levelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap),
		])
	}

	override func updateViews() {
		guard let model = model as? UserHeaderModel else { return }
		ImageCashingService.shared.getImage(for: model.imageUrl) { [weak self] image in
			DispatchQueue.main.async {
				self?.profileImageView.image = image
			}
		}
		nameLabel.text = model.name
		walletLabel.text = "\("Wallet".padding(toLength: 7, withPad: " ", startingAt: 0)) \(model.wallet) ₳"
		correctionPointsLabel.text = "Evaluation points \(model.correctionPoints)"
		if let pool = model.pool {
			rightStack.addArrangedSubview(poolLabel)
			poolLabel.text = "\("Pool".padding(toLength: 7, withPad: " ", startingAt: 0)) \(pool.capitalized)"
		} else {
			rightStack.removeArrangedSubview(poolLabel)
		}
		if model.staff {
			rightStack.insertArrangedSubview(staffLabel, at: 1)
		} else {
			rightStack.removeArrangedSubview(staffLabel)
		}
		locationLabel.text = "Location \(model.location)"
		emailLabel.text = "Email \(model.email)"
		phoneLabel.text = "Mobile \(model.phone)"
		guard let cursusUser = model.cursuses.last else {
			cursusView.isHidden = true
			levelView.isHidden = true
			return
		}
		cursusView.text = "Cursus \(cursusUser.cursus.name) ▼"
		cursusView.isHidden = false
		levelView.configure(level: cursusUser.level, progress: cursusUser.level - cursusUser.level.rounded(.down))
		chosenIndex = model.cursuses.count - 1
		pickerView.selectRow(chosenIndex!, inComponent: 0, animated: true)
	}

	func removeKeyboard() {
		cursusView.resignFirstResponder()
	}
}

extension UserHeader: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		guard let model = model as? UserHeaderModel else { return 0 }
		return model.cursuses.count
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		guard let model = model as? UserHeaderModel else { return nil }
		return model.cursuses[row].cursus.name
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guard let model = model as? UserHeaderModel else { return }
		cursusUser = model.cursuses[row]
	}
}
extension UserHeader: ToolbarPickerViewDelegate {
	func didTapDone() {
		cursusView.resignFirstResponder()
		guard let cursusUser = cursusUser else { return }
		levelView.configure(level: cursusUser.level, progress: cursusUser.level - cursusUser.level.rounded(.down))
		cursusView.text = "Cursus \(cursusUser.cursus.name) ▼"
		guard let presenter = presenter as? CellToPresenterUserMainProtocol else { return }
		presenter.didSelectCursus(cursusUser)
		guard let model = model as? UserHeaderModel else { return }
		chosenIndex = model.cursuses.firstIndex{ $0.cursusId == cursusUser.cursusId }
		pickerView.selectRow(chosenIndex ?? 0, inComponent: 0, animated: true)
	}

	func didTapCancel() {
		cursusView.resignFirstResponder()
		pickerView.selectRow(chosenIndex ?? 0, inComponent: 0, animated: true)
	}
}

final class UserProfileProgressView: UIView {
	private lazy var progressBar: UIProgressView = {
		let view = UIProgressView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.trackTintColor = UIColor(red: 0.13, green: 0.13, blue: 0.15, alpha: 0.50)
		view.progressTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.74, alpha: 1.00)
		return view
	}()

	private lazy var textInProgress: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		return label
	}()

	required init() {
		super.init(frame: .zero)
		addSubviews()
		makeConstraints()
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(level: Float, progress: Float) {
		textInProgress.text = "level \("\(level)".replacingOccurrences(of: ".", with: " - ")) %"
		progressBar.progress = progress
	}
}

private extension UserProfileProgressView {
	func addSubviews() {
		addSubview(progressBar)
		progressBar.addSubview(textInProgress)
	}

	func makeConstraints() {
		NSLayoutConstraint.activate(
			[
				progressBar.topAnchor.constraint(equalTo: topAnchor),
				progressBar.bottomAnchor.constraint(equalTo: bottomAnchor),
				progressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
				progressBar.trailingAnchor.constraint(equalTo: trailingAnchor),
				progressBar.heightAnchor.constraint(equalToConstant: 20),

				textInProgress.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
				textInProgress.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor)
			]
		)
	}
}

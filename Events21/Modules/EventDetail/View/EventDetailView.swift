//
//  EventDetailView.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

//TODO: Инфа по ивенту + кнопка зарегистирроваться/отрегестрироваться


import UIKit

class EventDetailView: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterEventProtocol!

    let textView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isEditable = false
		textView.textColor = .white
		textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

	lazy var registerButton: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(buttonDidTapped))
		button.tintColor = .white
		button.setBackgroundImage(
			UIColor.cyan.withAlphaComponent(0.3).image(CGSize(width: 150, height: 30)),
			for: .normal,
			barMetrics: .default
		)
		return button
	}()

	lazy var unRegisterButton: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Unregister", style: .done, target: self, action: #selector(buttonDidTapped))
		button.tintColor = .white
		button.setBackgroundImage(
			UIColor.red.withAlphaComponent(0.3).image(CGSize(width: 150, height: 30)),
			for: .normal,
			barMetrics: .default
		)
		return button
	}()
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        view.isHidden = true
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(textView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
])

    }
    @objc private func buttonDidTapped(){
         presenter.buttonDidTapped()
    }
}

extension EventDetailView: PresenterToViewEventProtocol{
    func setTextView(text: NSAttributedString) {
        DispatchQueue.main.async {
            self.textView.attributedText = text
        }
    }

    func showAlert(with message: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    func showAlert(title: String, message: String, completion: (() -> Void)?) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: completion)
        }
    }

    func setButtonUnregistered() {
        DispatchQueue.main.async { [self] in
			navigationItem.setRightBarButton(unRegisterButton, animated: true)
		}
    }

    func setButtonRegistered() {
        DispatchQueue.main.async { [self] in
			navigationItem.setRightBarButton(registerButton, animated: true)
		}
    }

    func hideButton() {
        DispatchQueue.main.async { [self] in
			navigationItem.setRightBarButton(nil, animated: true)
        }
    }

    func show() {
        DispatchQueue.main.async { [self] in
            view.isHidden = false
        }
    }
}


private extension UIBarButtonItem {
	convenience init(customView: UIView, target: AnyObject?, action: Selector?) {
		self.init(customView: customView)
		self.target = target
		self.action = action
	}
}

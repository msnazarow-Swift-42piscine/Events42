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
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .cyan
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40 * verticalTranslation)
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.isHidden = true
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(textView)
        view.addSubview(registerButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7),
            registerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10)
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
            registerButton.setTitle("Unregister", for: .normal)
            registerButton.backgroundColor = .red
        }
    }

    func setButtonRegistered() {
        DispatchQueue.main.async { [self] in
            registerButton.setTitle("Register", for: .normal)
            registerButton.backgroundColor = .cyan
        }
    }

    func hideButton() {
        DispatchQueue.main.async { [self] in
            registerButton.isHidden = true
        }
    }

    func show() {
        DispatchQueue.main.async { [self] in
            view.isHidden = false
        }
    }
}


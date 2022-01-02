//
//  AuthorizationViewController.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

// TODO: Авторизация пользователя, webView? 


import UIKit
import WebKit


class AuthorizationViewController: UIViewController {
    // MARK: - Properties
    var presenter: ViewToPresenterAuthorizationProtocol!

	let imageView: UIImageView = {
		let view = UIImageView(image: UIImage(named: "42logo"))
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		return view
	}()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
		button.titleLabel?.font = UIFont(name: "PingFangHK-Semibold", size: 25 * verticalTranslation)
		button.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.74, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
		button.isHidden = true
        return button
    }()

    let webView = WKWebView()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter.viewWillAppear()
	}

    private func setupUI() {
		navigationController?.navigationBar.isHidden = true
        webView.navigationDelegate = self
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		addSubviews()
		setupConstraints()
    }

	private func addSubviews() {
		view.addSubview(loginButton)
		view.addSubview(imageView)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loginButton.widthAnchor.constraint(equalToConstant: 200),
			loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
			imageView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -50),
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		])
	}

    @objc private func buttonDidTapped() {
        presenter.buttonDidTapped()
    }
}

extension AuthorizationViewController: PresenterToViewAuthorizationProtocol {
    func loadRequest(request: URLRequest) {
        webView.load(request)
    }

    func showAlert(title: String, message: String, completion: (() -> Void)?) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: completion)
        }
    }

	func setLoginButtonHidden(_ hidden: Bool) {
		DispatchQueue.main.async { [self] in
			loginButton.isHidden = hidden
		}
	}
}


extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
            }
            let exceptions = SecTrustCopyExceptions(serverTrust)
            SecTrustSetExceptions(serverTrust, exceptions)
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
}

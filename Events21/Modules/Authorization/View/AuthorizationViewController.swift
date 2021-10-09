//
//  AuthorizationViewController.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

//TODO: Авторизация пользователя, webView? 


import UIKit
import WebKit


class AuthorizationViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterAuthorizationProtocol!

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20 * verticalTranslation)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor.cyan.cgColor
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let webView = WKWebView()
    override func loadView() {
        view = webView
    }
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        webView.navigationDelegate = self
        view.backgroundColor = .white
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc private func didTapLoginButton() {
        presenter.didTapLoginButton()
    }
}

extension AuthorizationViewController: PresenterToViewAuthorizationProtocol{
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
}


extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
            }
            let exceptions = SecTrustCopyExceptions(serverTrust)
            SecTrustSetExceptions(serverTrust, exceptions)
            completionHandler(.useCredential, URLCredential(trust: serverTrust));
    }
}

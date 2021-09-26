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

    lazy var webView: WKWebView = {
        let webview = WKWebView(frame: view.bounds)
        let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=304465722129fb447b62e46570c95cbad281250121c76f71a64fd9b0098baaa9&redirect_uri=http%3A%2F%2Fexample.com&response_type=code")
        webview.load(URLRequest(url: url!))
        webview.navigationDelegate = self
        return webview
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(webView)
    }

    private func setupConstraints() {

    }
}

extension AuthorizationViewController: PresenterToViewAuthorizationProtocol{
    
}

extension AuthorizationViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
//        print(navigationResponse)
//    }
}

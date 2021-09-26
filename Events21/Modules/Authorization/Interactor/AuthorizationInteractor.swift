//
//  AuthorizationInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit

class AuthorizationInteractor: PresenterToInteractorAuthorizationProtocol {
    let redirecdedUrl = "events21://events21".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!

    lazy var url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=304465722129fb447b62e46570c95cbad281250121c76f71a64fd9b0098baaa9&redirect_uri=\(redirecdedUrl)&response_type=code&scope=public%20forum&state=coucou")

    func openIntra() {
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}

//
//  IntraAPIService.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//

import Foundation

class IntraAPIService: NSObject, IntraAPIServiceProtocol {
    let redirecdedUrl = "events21://events21"
    let uid = "304465722129fb447b62e46570c95cbad281250121c76f71a64fd9b0098baaa9"
    let secret = "9dd7cc32e3dd76eccfcd4587cd3a435ac3826d35c86715c92207aa8b868f06d1"
    var token = KeychainHelper.standard.read(service: .token, account: .intra42, type: TokenResponse.self)
    var code = KeychainHelper.standard.read(service: .code, account: .intra42, type: String.self)
    var me: MeResponse!

    var urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        return urlComponents
    }()

    var request: URLRequest{
        var request = URLRequest(url: urlComponents.url!)
        if let token = token {
            request.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }

    static let shared = IntraAPIService()

	private override init() {
		super.init()
	}
}

//
//  AuthorizationInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit

class AuthorizationInteractor: PresenterToInteractorAuthorizationProtocol {
    let intraAPIService: IntraAPIServiceAuthProtocol


    init(intraAPIService: IntraAPIServiceAuthProtocol) {
        self.intraAPIService = intraAPIService
    }

    func getUserCode(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        intraAPIService.getUserCode(completion: completion)
    }

    func getToken(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        intraAPIService.getToken(completion: completion)
    }

    func hasToken() -> Bool {
        intraAPIService.hasToken()
    }
}

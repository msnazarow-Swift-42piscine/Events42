//
//  AuthorizationInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import Foundation

class AuthorizationInteractor: PresenterToInteractorAuthorizationProtocol {
    let intraAPIService = IntraAPIService()
    func getRecentEvents(for userID: String, complition: @escaping (Result<[EventResponse], Error>) -> Void) {
        intraAPIService.getRecentEvents(for: userID, complition: complition)
    }
}

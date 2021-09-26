//
//  UserInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

class UserInteractor: PresenterToInteractorUserProtocol {
    let intraAPIService: IntraAPIServiceProtocol
    let imageCashingService: ImageCashingServiceProtocol

    init(intraAPIService: IntraAPIServiceProtocol, imageCashingService: ImageCashingServiceProtocol) {
        self.intraAPIService = intraAPIService
        self.imageCashingService = imageCashingService
    }

    func getRecentEvents(with token: String, complition: @escaping (Result<[EventResponse], Error>) -> Void) {
        intraAPIService.getRecentEvents(with: token, complition: complition)
    }

    func getMe(with token: String, comlition: @escaping (MeResponse) -> Void) {
        intraAPIService.getMe(with: token, comlition: comlition)
    }
    
    func getToken(with code: String, complition: @escaping (String) -> Void) {
        intraAPIService.getToken(with: code, complition: complition)
    }
    func getImage(for url: String, complition: @escaping (UIImage?) -> Void) {
        imageCashingService.getImage(for: url, comlition: complition)
    }
}

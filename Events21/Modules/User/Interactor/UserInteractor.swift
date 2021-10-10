//
//  UserInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

class UserInteractor: PresenterToInteractorUserProtocol {
    let intraAPIService: IntraAPIServiceProtocol & IntraAPIServiceAuthProtocol
    let imageCashingService: ImageCashingServiceProtocol

    init(intraAPIService: IntraAPIServiceProtocol & IntraAPIServiceAuthProtocol, imageCashingService: ImageCashingServiceProtocol) {
        self.intraAPIService = intraAPIService
        self.imageCashingService = imageCashingService
    }

    func getEvents(campusId: Int?, cursusId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        intraAPIService.getFutureEvents(campusId: campusId, cursusId: cursusId, sort: sort, filter: filter, completion: completion)
    }

    func getUserEvents(completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        intraAPIService.getUserEvents(completion: completion)
    }

    func getMe(comlition: @escaping (Result<MeResponse, IntraAPIError>) -> Void) {
        intraAPIService.getMe(completion: comlition)
    }

    func getImage(for url: String, completion: @escaping (UIImage?) -> Void) {
        imageCashingService.getImage(for: url, comlition: completion)
    }
    func removeToken(){
        intraAPIService.removeCode()
        intraAPIService.removeToken()
    }
}

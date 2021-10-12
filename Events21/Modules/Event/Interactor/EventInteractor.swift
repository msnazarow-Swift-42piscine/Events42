//
//  EventInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import Foundation

class EventInteractor: PresenterToInteractorEventProtocol {

    let intraAPIService: IntraAPIServiceProtocol

    init(intraAPIService: IntraAPIServiceProtocol) {
        self.intraAPIService = intraAPIService
    }
    func registerToEvent(eventId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void){
        intraAPIService.registerToEvent(eventId: eventId, completion: completion)
    }
}

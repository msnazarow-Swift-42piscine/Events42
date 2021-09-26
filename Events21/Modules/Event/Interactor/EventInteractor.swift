//
//  EventInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import Foundation

class EventInteractor: PresenterToInteractorEventProtocol {

    let intraAPIService = IntraAPIService.shared
    func registerToEvent(userId: Int, eventId: Int, complition: @escaping (Bool) -> Void){
        intraAPIService.registerToEvent(userId: userId, eventId: eventId, complition: complition)
    }
}

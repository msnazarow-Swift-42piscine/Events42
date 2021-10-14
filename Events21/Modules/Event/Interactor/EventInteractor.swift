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
    
    func registerToEvent(eventId: Int, completion: @escaping (Result<EventUsersResponse, IntraAPIError>) -> Void){
        intraAPIService.registerToEvent(eventId: eventId, completion: completion)
    }

    func unregisterFromEvent(eventUserId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void){
        intraAPIService.unregisterFromEvent(eventUserId: eventUserId, completion: completion)
    }

    func getUserEvents(userIds: [Int], eventIds: [Int], sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        let group = DispatchGroup()
        var resultError: IntraAPIError?
        var resultEvents: [EventUsersResponse] = []
        let arrays: [(String, [Int])] = [(.userId, userIds), (.eventId, eventIds)].sorted(by: { $0.1.count > $1.1.count })
                if !arrays[0].1.isEmpty {
                    arrays[0].1.forEach { value0 in
                        if !arrays[1].1.isEmpty {
                            arrays[1].1.forEach { value1 in
                                group.enter()
                                intraAPIService.getUserEvents(userId: [value0, value1][arrays.firstIndex(where: {$0.0 == .userId})!],
                                                              eventId: [value0, value1][arrays.firstIndex(where: {$0.0 == .eventId})!],
                                                              sort: sort,
                                                              filter: filter) { result in
                                    defer { group.leave() }
                                    switch result {
                                    case .failure(let error):
                                        resultError = error
                                    case .success(let events):
                                        resultEvents.append(contentsOf: events)
                                    }
                                }
                            }
                } else {
                    group.enter()
                    intraAPIService.getUserEvents(userId: arrays[0].0 == .userId ? value0 : nil,
                                                  eventId: arrays[0].0 == .eventId ? value0 : nil,
                                                  sort: sort,
                                                  filter: filter) { result in
                        defer { group.leave() }
                        switch result {
                        case .failure(let error):
                            resultError = error
                        case .success(let events):
                            resultEvents.append(contentsOf: events)
                        }
                    }
                }
            }
        } else {
            group.enter()
            intraAPIService.getUserEvents(userId: nil,
                                          eventId: nil,
                                          sort: sort,
                                          filter: filter) { result in
                defer { group.leave() }
                switch result {
                case .failure(let error):
                    resultError = error
                case .success(let events):
                    resultEvents.append(contentsOf: events)
                }
            }
        }
        group.notify(queue: .main) {
            if let error = resultError {
                completion(.failure(error))
            } else {
                completion(.success(resultEvents))
            }
        }
    }
}

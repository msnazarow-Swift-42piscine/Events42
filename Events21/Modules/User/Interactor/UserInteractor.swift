//
//  UserInteractor.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit
import OrderedCollections

class UserInteractor: PresenterToInteractorUserProtocol {
    let intraAPIService: IntraAPIServiceProtocol & IntraAPIServiceAuthProtocol
    let imageCashingService: ImageCashingServiceProtocol
    let filterStorage: FiltersStorageProtocol

    init(intraAPIService: IntraAPIServiceProtocol & IntraAPIServiceAuthProtocol,
         imageCashingService: ImageCashingServiceProtocol,
         filterStorage: FiltersStorageProtocol) {
        self.intraAPIService = intraAPIService
        self.imageCashingService = imageCashingService
        self.filterStorage = filterStorage
    }

    func getEvents(campusIds: [Int], cursusIds: [Int], userIds: [Int], sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        let group = DispatchGroup()
        var resultError: IntraAPIError?
        var resultEvents: [EventResponse] = []
        let arrays: [(String, [Int])] = [(.campusId, campusIds), (.cursusId, cursusIds), (.userId, userIds)].sorted(by: { $0.1.count > $1.1.count })
        if !arrays[0].1.isEmpty {
            arrays[0].1.forEach { value0 in
                if !arrays[1].1.isEmpty {
                    arrays[1].1.forEach { value1 in
                        if !arrays[2].1.isEmpty {
                            arrays[2].1.forEach { value2 in
                                group.enter()
                                intraAPIService.getEvents(campusId: [value0, value1, value2][arrays.firstIndex(where: {$0.0 == .campusId})!],
                                                          cursusId: [value0, value1, value2][arrays.firstIndex(where: {$0.0 == .cursusId})!],
                                                          userId: [value0, value1, value2][arrays.firstIndex(where: {$0.0 == .userId})!],
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
                            intraAPIService.getEvents(campusId: arrays[0...1].contains(where: { $0.0 == .campusId }) ? [value0, value1][arrays.firstIndex(where: {$0.0 == .campusId})!] : nil,
                                                      cursusId: arrays[0...1].contains(where: { $0.0 == .cursusId }) ? [value0, value1][arrays.firstIndex(where: {$0.0 == .cursusId})!] : nil,
                                                      userId: arrays[0...1].contains(where: { $0.0 == .userId }) ? [value0, value1][arrays.firstIndex(where: {$0.0 == .userId})!] : nil,
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
                    intraAPIService.getEvents(campusId: arrays[0].0 == .campusId ? value0 : nil,
                                              cursusId: arrays[0].0 == .cursusId ? value0 : nil,
                                              userId: arrays[0].0 == .userId ? value0 : nil,
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
            intraAPIService.getEvents(campusId: nil,
                                      cursusId: nil,
                                      userId: nil,
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

    func saveFilters(filters: OrderedDictionary<String, Bool>) {
        filterStorage.saveFilters(filters: filters)
    }

    func loadFilters() -> OrderedDictionary<String, Bool>? {
        filterStorage.loadFilters()
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

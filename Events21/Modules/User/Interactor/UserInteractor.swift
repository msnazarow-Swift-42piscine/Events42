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
        intraAPIService.getEvents(campusIds: campusIds,
                                  cursusIds: cursusIds,
                                  userIds: userIds,
                                  sort: sort,
                                  filter: filter,
                                  completion: completion)
    }

    func getUserEvents(userIds: [Int], eventIds: [Int], sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        intraAPIService.getUserEvents(userIds: userIds,
                                      eventIds: eventIds,
                                      sort: sort,
                                      filter: filter,
                                      completion: completion)
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

//
//  EventListFiltersInteractor.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//  
//

import Foundation
import OrderedCollections

class EventListFiltersInteractor: PresenterToInteractorFiltersProtocol {
    func saveFilters(filters: OrderedDictionary<String, Bool>) {
        UserDefaults.standard.set(object: filters, forKey: .filters)
    }

    func loadFilters() -> OrderedDictionary<String, Bool>? {
        return UserDefaults.standard.object(OrderedDictionary<String, Bool>.self, with: .filters)
    }
}

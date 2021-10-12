//
//  FiltersService.swift
//  Events21
//
//  Created by out-nazarov2-ms on 12.10.2021.
//

import OrderedCollections
import Foundation

protocol FiltersStorageProtocol {
    func saveFilters(filters: OrderedDictionary<String, Bool>)
    func loadFilters() -> OrderedDictionary<String, Bool>?
}

class FiltersStorage: FiltersStorageProtocol {
    static let shared = FiltersStorage()

    private init() {}

    func saveFilters(filters: OrderedDictionary<String, Bool>) {
        UserDefaults.standard.set(object: filters, forKey: .filters)
    }

    func loadFilters() -> OrderedDictionary<String, Bool>? {
        return UserDefaults.standard.object(OrderedDictionary<String, Bool>.self, with: .filters)
    }
}

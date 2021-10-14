//
//  Sequence+Ext.swift
//  Events21
//
//  Created by out-nazarov2-ms on 14.10.2021.
//

import Foundation

extension Sequence {
    func sorted( by Predicates: [(Element, Element) -> Bool]) -> [Element] {
    return sorted(by:) { lhs, rhs in
      for predicate in Predicates {
        if predicate(lhs, rhs) { return true }
        if predicate(rhs, lhs) { return false }
      }
      return false
    }
  }
}

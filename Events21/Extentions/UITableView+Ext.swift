//
//  UITableView+Ext.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//

import UIKit

extension UITableView {
    func register(_ cellClass: AnyClass){
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
    }
}

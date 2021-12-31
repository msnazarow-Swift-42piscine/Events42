//
//  CellIdentifiable.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit

class CellIdentifiable: UITableViewCell, ModelRepresentable {
    weak var presenter: AnyObject!

    var model: Identifiable? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {}
}

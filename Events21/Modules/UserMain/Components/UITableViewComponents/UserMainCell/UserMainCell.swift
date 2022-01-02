//
//  UserMainCell.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit

class UserMainCell: CellIdentifiable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? UserMainCellModel else { return }
    }
}

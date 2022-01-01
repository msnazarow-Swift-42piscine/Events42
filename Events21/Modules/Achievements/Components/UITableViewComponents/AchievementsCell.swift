//
//  AchievementsCell.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 01.01.2022.
//  
//

import UIKit

class AchievementsCell: CellIdentifiable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? AchievementCellModel else { return }

    }
}

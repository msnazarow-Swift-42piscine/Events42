//
//  SearchUserCell.swift
//  ___MODULENAME___
//
//  Created by 19733654 on 28.12.2021.
//  
//

import UIKit

class SearchUserCell: CellIdentifiable {
//
//	let imageView: UIImageView = {
//		let imageView = UIImageView()
//		imageView.translatesAutoresizingMaskIntoConstraints = false
//		imageView.contentMode = .scaleAspectFit
//		return imageView
//	}()
//
//	let la
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? SearchUserCellModel else { return }

    }
}

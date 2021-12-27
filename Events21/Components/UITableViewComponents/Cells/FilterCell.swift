//
//  FilterCell.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//

import UIKit

struct FilterModel {
    let name: String
    let value: Bool
}

struct FilterCellModel: Identifiable {

    var identifier: String { return "FilterCell" }

    let name: String
    let value: Bool

    init(_ property: FilterModel) {
        name = property.name
        value = property.value
    }
}


class FilterCell: CellIdentifiable {
    let gap: CGFloat = 10

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(switcherDidChanged), for: .valueChanged)
        return switcher
    }()

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, switcher])
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: gap),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -gap)
        ])
        switcher.addTarget(self, action: #selector(switcherDidChanged), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? FilterCellModel else { return }
        label.text = "Show only \(model.name) events"
        switcher.isOn = model.value
    }

    @objc func switcherDidChanged(){
        guard let model = model as? FilterCellModel,
			  let presenter = presenter as? CellToPresenterFiltersProtocol else { return }
        presenter.switcherDidChanged(model.name)
    }
}

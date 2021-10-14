//
//  SortCellModel.swift
//  Events21
//
//  Created by out-nazarov2-ms on 13.10.2021.
//

import UIKit

struct SortModel {
    let sortName: String?
    let isActive: Bool
    let number: Int
    let inputView: ToolbarPickerView
}

struct SortCellModel: CellIdentifiable {

    var identifier: String { return "SortCell" }

    let sortName: String?
    let isActive: Bool
    let number: Int
    let inputView: ToolbarPickerView

    init(_ property: SortModel) {
        sortName = property.sortName
        isActive = property.isActive
        number = property.number
        inputView = property.inputView
    }
}

class SortCell: Cell {
    let gap: CGFloat = 10

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, textField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: gap),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -gap),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap),
            textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? SortCellModel else { return }
        label.text = "\(model.number == 0 ? "First" : "Then") sort by: "
        textField.text = model.sortName
        textField.isUserInteractionEnabled = model.isActive
        textField.inputView = model.inputView
        textField.inputAccessoryView = model.inputView.toolbar
    }

    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let model = model as? SortCellModel else { return }
        presenter.textFieldDidBeginEditing(model.number)
    }
}


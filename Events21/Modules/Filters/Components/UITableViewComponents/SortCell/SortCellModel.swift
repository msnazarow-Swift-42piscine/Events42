//
//  SortCellModel.swift
//  Events21
//
//  Created by out-nazarov2-ms on 13.10.2021.
//

struct SortCellModel: Identifiable {
    let identifier = "SortCell"
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

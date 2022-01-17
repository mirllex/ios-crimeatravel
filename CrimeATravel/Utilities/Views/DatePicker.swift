//
//  DatePicker.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

final class DatePicker: UIDatePicker {
    
    private enum Constant {
        static let pickerHeight: CGFloat = 240
    }
    
    private var textField: UITextField
    
    
    init(textField: UITextField) {
        self.textField = textField
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,
                                 height: Constant.pickerHeight))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        datePickerMode = .date
        backgroundColor = .white
        if #available(iOS 13.4, *) {
            preferredDatePickerStyle = .wheels
        }
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        let toolBar = Toolbar(doneSelector: #selector(doneAction), target: self)
        textField.inputAccessoryView = toolBar
    }
    
    @objc
    private func valueChanged() {
        textField.text = date.getAsString()
    }
    
    @objc
    private func doneAction() {
        textField.text = date.getAsString()
        textField.resignFirstResponder()
        _ = textField.delegate?.textFieldShouldReturn?(textField)
    }
    
}

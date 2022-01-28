//
//  DisabledTextField.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 19.01.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class DisabledTextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}

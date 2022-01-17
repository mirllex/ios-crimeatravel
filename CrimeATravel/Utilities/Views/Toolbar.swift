//
//  ToolBar.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

final class Toolbar: UIToolbar {
    
    private enum Constant {
        static let height: CGFloat = 44
        static let fontSize: CGFloat = 17
    }
    
    private var doneSelector: Selector
    private var target: UIView
    
    init(doneSelector: Selector, target: UIView) {
        self.doneSelector = doneSelector
        self.target = target
        
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,
                                 height: Constant.height))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .plain,
                                         target: target,
                                         action: #selector(doneAction))
        doneButton.tintColor = UIColor(named: "accent_color")
        doneButton.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: Constant.fontSize,
                                                                    weight: .semibold)], for: .normal)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                          target: nil, action: nil)
        
        setItems([spaceButton, doneButton], animated: false)
    }
    
    @IBAction private func doneAction() {
        perform(doneSelector)
    }
    
}

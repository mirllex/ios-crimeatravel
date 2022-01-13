//
//  LogoBarButtonItem.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit

final class LogoBarButtonItem: UIBarButtonItem {
    
    let button = UIButton(type: .system)
    
    override init() {
        super.init()
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        button.frame = CGRect(x: 0, y: 0, width: 96, height: 25)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        let image = UIImage(named: "home_logo")
        button.setBackgroundImage(image, for: .normal)
        self.customView = button
    }
}

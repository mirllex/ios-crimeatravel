//
//  UINavigationBar+Ex.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    var isHidesShadow: Bool {
        get {
            standardAppearance.shadowColor == .clear
        }
        set {
            let appearence = UINavigationBarAppearance()
            if newValue {
                appearence.shadowColor = .clear
                appearence.shadowImage = UIImage()
            }
            standardAppearance = appearence
            scrollEdgeAppearance = appearence
        }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        standardAppearance.backgroundColor = color
        scrollEdgeAppearance?.backgroundColor = color
//        if color == .clear {
//            standardAppearance.configureWithTransparentBackground()
//            scrollEdgeAppearance?.configureWithTransparentBackground()
//        } else {
//            standardAppearance.configureWithDefaultBackground()
//            scrollEdgeAppearance?.configureWithDefaultBackground()
//        }
    }
    
    func setShadowColor(_ color: UIColor) {
        standardAppearance.shadowColor = color
        scrollEdgeAppearance?.shadowColor = color
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.childForStatusBarStyle?.preferredStatusBarStyle ?? .default
    }
}

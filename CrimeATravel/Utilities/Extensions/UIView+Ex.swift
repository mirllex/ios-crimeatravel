//
//  UIView+Ex.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyGradient(colors: [UIColor]) {
        self.applyGradient(colors: colors, locations: nil)
    }
    
    func applyGradient(colors: [UIColor],
                       locations: [NSNumber]? = nil,
                       radius: CGFloat? = 0,
                       widthContstant: CGFloat = 0,
                       rect: CGRect? = nil,
                       type: CAGradientLayerType = .axial,
                       startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
                       endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) {
        
        if let layers = self.layer.sublayers {
            for layer in layers {
                if layer.name == "bgGradient" {
                    layer.removeFromSuperlayer()
                }
            }
        }

        let gradient = CAGradientLayer()
        gradient.name = "bgGradient"
        gradient.type = type
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        if rect != nil {
            gradient.frame = rect!
        } else {
            gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width - widthContstant, height: self.bounds.height)
        }
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = radius!
        gradient.cornerCurve = .continuous
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}

//
//  TButton.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit

class TButton: UIButton {
    
    private let loadingSpinner = CustomSpinnerView(radius: 14, color: .white)
    
    private var buttonCenter: CGPoint {
        let buttonHeight = bounds.size.height
        let buttonWidth = bounds.size.width
        return CGPoint(x: buttonWidth/2, y: buttonHeight/2)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 6
        layer.cornerCurve = .continuous
    }
    
    func startLoading() {
        isEnabled = false
        loadingSpinner.center = buttonCenter
        loadingSpinner.sizeToFit()
        addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        titleLabel?.alpha = 0
    }
    
    func stopLoading() {
        isEnabled = true
        loadingSpinner.stopAnimating()
        loadingSpinner.removeFromSuperview()
        UIView.animate(withDuration: 0.17) {
            self.titleLabel?.alpha = 1
        }
    }
}

//
//  CTButton.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 19.01.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class CTButton: UIButton {

    private let loadingSpinner = CustomSpinnerView(radius: 14, color: .white)
    private var tmpTitle: String?
    
    private var buttonCenter: CGPoint {
        let buttonHeight = bounds.size.height
        let buttonWidth = bounds.size.width
        return CGPoint(x: buttonWidth/2, y: buttonHeight/2)
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor(named: "accentColor")
        
        layer.cornerRadius = 6
        layer.cornerCurve = .continuous
        
        //titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
//        titleLabel?.textColor = .white
    }
        
    func startLoading() {
        isEnabled = false
        loadingSpinner.center = buttonCenter
        loadingSpinner.sizeToFit()
        addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        
        tmpTitle = title(for: .normal)
        setTitle(nil, for: .normal)
//        print(titleLabel)
//        titleLabel?.text = nil//alpha = 0
    }
    
    func stopLoading() {
        isEnabled = true
        loadingSpinner.stopAnimating()
        loadingSpinner.removeFromSuperview()
        setTitle(tmpTitle, for: .normal)
//        UIView.animate(withDuration: 0.17) {
//            self.titleLabel?.alpha = 1
//        }
    }
}

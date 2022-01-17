//
//  CustomSpinnerView.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class CustomSpinnerView: UIView {
    
    private let drawableLayer = CAShapeLayer()
    private var radius: CGFloat = 18
    private var isAnimating: Bool = false
    
    var color: UIColor = .white {
        didSet {
            drawableLayer.strokeColor = color.cgColor
        }
    }
    
    var lineWidth: CGFloat = 3 {
        didSet {
            drawableLayer.lineWidth = self.lineWidth
            self.updatePath()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            updateFrame()
            updatePath()
        }
    }
    
    convenience init(radius: CGFloat = 18.0, color: UIColor = .white) {
        self.init(frame: .zero)
        
        self.radius = radius
        self.color = color
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
        updatePath()
    }
    
    func startAnimating() {
        guard !isAnimating else { return }
        isAnimating = true
        isHidden = false
        setupAnimation(in: drawableLayer, size: .zero)
    }
    
    func stopAnimating() {
        guard isAnimating else { return }
        drawableLayer.removeAllAnimations()
        isAnimating = false
        isHidden = true
    }
    
    private func setup() {
        isHidden = true
        layer.addSublayer(drawableLayer)
        drawableLayer.strokeColor = color.cgColor
        drawableLayer.lineWidth = lineWidth
        drawableLayer.fillColor = UIColor.clear.cgColor
        drawableLayer.lineJoin = CAShapeLayerLineJoin.round
        drawableLayer.strokeStart = 0.99
        drawableLayer.strokeEnd = 1
        updateFrame()
        updatePath()
    }
    
    private func updateFrame() {
        drawableLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    private func updatePath() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius: CGFloat = radius - lineWidth
        
        drawableLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(2 * Double.pi),
            clockwise: true
        ).cgPath
    }
    
    private func setupAnimation(in layer: CALayer, size: CGSize) {
        layer.removeAllAnimations()
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnim.fromValue = 0
        rotationAnim.duration = 4
        rotationAnim.toValue = 2 * Double.pi
        rotationAnim.repeatCount = Float.infinity
        rotationAnim.isRemovedOnCompletion = false
        
        let startHeadAnim = CABasicAnimation(keyPath: "strokeStart")
        startHeadAnim.beginTime = 0.1
        startHeadAnim.fromValue = 0
        startHeadAnim.toValue = 0.25
        startHeadAnim.duration = 1
        startHeadAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let startTailAnim = CABasicAnimation(keyPath: "strokeEnd")
        startTailAnim.beginTime = 0.1
        startTailAnim.fromValue = 0
        startTailAnim.toValue = 1
        startTailAnim.duration = 1
        startTailAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let endHeadAnim = CABasicAnimation(keyPath: "strokeStart")
        endHeadAnim.beginTime = 1
        endHeadAnim.fromValue = 0.25
        endHeadAnim.toValue = 0.99
        endHeadAnim.duration = 0.5
        endHeadAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let endTailAnim = CABasicAnimation(keyPath: "strokeEnd")
        endTailAnim.beginTime = 1
        endTailAnim.fromValue = 1
        endTailAnim.toValue = 1
        endTailAnim.duration = 0.5
        endTailAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let strokeAnimGroup = CAAnimationGroup()
        strokeAnimGroup.duration = 1.5
        strokeAnimGroup.animations = [startHeadAnim, startTailAnim, endHeadAnim, endTailAnim]
        strokeAnimGroup.repeatCount = Float.infinity
        strokeAnimGroup.isRemovedOnCompletion = false
        
        layer.add(rotationAnim, forKey: "rotation")
        layer.add(strokeAnimGroup, forKey: "stroke")
    }
}

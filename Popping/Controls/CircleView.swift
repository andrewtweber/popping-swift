//
//  CircleView.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class CircleView: UIView
{
    var strokeColor: UIColor!
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assert(frame.size.width == frame.size.height, "A circle must have the same height and width.")
        self.addCircleLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Property setters
    
    func setStrokeEnd(_ strokeEnd: CGFloat, animated: Bool) {
        if (animated) {
            self.animateToStrokeEnd(strokeEnd)
            return
        }
        self.circleLayer.strokeEnd = strokeEnd
    }
    
    func setStrokeColor(_ strokeColor: UIColor) {
        self.circleLayer.strokeColor = strokeColor.cgColor
        self.strokeColor = strokeColor
    }
    
    // MARK: - Private instance methods
    
    private func addCircleLayer() {
        let lineWidth: CGFloat = 4
        let radius: CGFloat = self.bounds.width / 2 - lineWidth / 2
        self.circleLayer = CAShapeLayer()
        let rect = CGRect(x: lineWidth / 2, y: lineWidth / 2, width: radius * 2, height: radius * 2)
        self.circleLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
        
        self.circleLayer.strokeColor = self.tintColor.cgColor
        self.circleLayer.fillColor = nil
        self.circleLayer.lineWidth = lineWidth
        self.circleLayer.lineCap = .round
        self.circleLayer.lineJoin = .round
        
        self.layer.addSublayer(self.circleLayer)
    }
    
    private func animateToStrokeEnd(_ strokeEnd: CGFloat) {
        if let strokeAnimation = POPSpringAnimation(propertyNamed: kPOPShapeLayerStrokeEnd) {
            strokeAnimation.toValue = strokeEnd
            strokeAnimation.springBounciness = 12
            strokeAnimation.removedOnCompletion = false
            
            self.circleLayer.pop_add(strokeAnimation, forKey: "layerStrokeAnimation")
        }
    }
}

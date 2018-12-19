//
//  PaperButton.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class PaperButton: UIControl
{
    var topLayer: CALayer!
    var middleLayer: CALayer!
    var bottomLayer: CALayer!
    var showMenu: Bool = false
    
    convenience init() {
        self.init(origin: CGPoint(x: 0, y: 0))
    }
    
    convenience init(origin: CGPoint) {
        self.init(frame: CGRect(x: origin.x, y: origin.y, width: 24, height: 17))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Instance methods
    
    override func tintColorDidChange() {
        let color = self.tintColor.cgColor
        self.topLayer.backgroundColor = color
        self.middleLayer.backgroundColor = color
        self.bottomLayer.backgroundColor = color
    }
    
    // MARK: - Private instance methods
    
    func setup() {
        let height: CGFloat = 2
        let width: CGFloat = self.bounds.width
        let cornerRadius: CGFloat = 1
        let color: CGColor = self.tintColor.cgColor
        
        self.topLayer = CALayer()
        self.topLayer.frame = CGRect(x: 0, y: self.bounds.minY, width: width, height: height)
        self.topLayer.cornerRadius = cornerRadius
        self.topLayer.backgroundColor = color
        
        self.middleLayer = CALayer()
        self.middleLayer.frame = CGRect(x: 0, y: self.bounds.midY - height/2, width: width, height: height)
        self.middleLayer.cornerRadius = cornerRadius
        self.middleLayer.backgroundColor = color
        
        self.bottomLayer = CALayer()
        self.bottomLayer.frame = CGRect(x: 0, y: self.bounds.maxY - height, width: width, height: height)
        self.bottomLayer.cornerRadius = cornerRadius
        self.bottomLayer.backgroundColor = color
        
        self.layer.addSublayer(self.topLayer)
        self.layer.addSublayer(self.middleLayer)
        self.layer.addSublayer(self.bottomLayer)
        
        self.addTarget(self, action: #selector(touchUpInsideHandler), for: .touchUpInside)
    }
    
    // MARK: - Event handlers
    
    @objc func touchUpInsideHandler(_ sender: PaperButton) {
        if (self.showMenu) {
            self.animateToMenu()
        } else {
            self.animateToClose()
        }
        
        self.showMenu = !self.showMenu
    }
    
    // MARK: - Animations
    
    func animateToMenu() {
        self.removeAllAnimations()
        
        let height: CGFloat = self.topLayer.bounds.height
        
        if let fadeAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity) {
            fadeAnimation.duration = 0.3
            fadeAnimation.toValue = 1
            self.middleLayer.pop_add(fadeAnimation, forKey: "fadeAnimation")
        }
        if let positionTopAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPosition) {
            positionTopAnimation.duration = 0.3
            positionTopAnimation.toValue = CGPoint(x: self.bounds.midX, y: self.bounds.minY + height/2)
            self.topLayer.pop_add(positionTopAnimation, forKey: "positionTopAnimation")
        }
        if let positionBottomAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPosition) {
            positionBottomAnimation.duration = 0.3
            positionBottomAnimation.toValue = CGPoint(x: self.bounds.midX, y: self.bounds.maxY - height/2)
            self.bottomLayer.pop_add(positionBottomAnimation, forKey: "positionBottomAnimation")
        }
        if let transformTopAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotation) {
            transformTopAnimation.toValue = 0
            transformTopAnimation.springBounciness = 20
            transformTopAnimation.springSpeed = 20
            transformTopAnimation.dynamicsTension = 1000
            self.topLayer.pop_add(transformTopAnimation, forKey: "transformTopAnimation")
        }
        if let transformBottomAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotation) {
            transformBottomAnimation.toValue = 0
            transformBottomAnimation.springBounciness = 20
            transformBottomAnimation.springSpeed = 20
            transformBottomAnimation.dynamicsTension = 1000
            self.bottomLayer.pop_add(transformBottomAnimation, forKey: "transformBottomAnimation")
        }
    }
    
    func animateToClose() {
        self.removeAllAnimations()
        
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        if let fadeAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity) {
            fadeAnimation.duration = 0.3
            fadeAnimation.toValue = 0
            self.middleLayer.pop_add(fadeAnimation, forKey: "fadeAnimation")
        }
        if let positionTopAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPosition) {
            positionTopAnimation.duration = 0.3
            positionTopAnimation.toValue = center
            self.topLayer.pop_add(positionTopAnimation, forKey: "positionTopAnimation")
        }
        if let positionBottomAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPosition) {
            positionBottomAnimation.duration = 0.3
            positionBottomAnimation.toValue = center
            self.bottomLayer.pop_add(positionBottomAnimation, forKey: "positionBottomAnimation")
        }
        if let transformTopAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotation) {
            transformTopAnimation.toValue = CGFloat.pi/4
            transformTopAnimation.springBounciness = 20
            transformTopAnimation.springSpeed = 20
            transformTopAnimation.dynamicsTension = 1000
            self.topLayer.pop_add(transformTopAnimation, forKey: "transformTopAnimation")
        }
        if let transformBottomAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotation) {
            transformBottomAnimation.toValue = -CGFloat.pi/4
            transformBottomAnimation.springBounciness = 20
            transformBottomAnimation.springSpeed = 20
            transformBottomAnimation.dynamicsTension = 1000
            self.bottomLayer.pop_add(transformBottomAnimation, forKey: "transformBottomAnimation")
        }
    }
    
    func removeAllAnimations() {
        self.topLayer.pop_removeAllAnimations()
        self.middleLayer.pop_removeAllAnimations()
        self.bottomLayer.pop_removeAllAnimations()
    }
}

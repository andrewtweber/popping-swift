//
//  FlatButton.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class FlatButton: UIButton
{
    convenience init() {
        self.init(type: .custom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var titleEdgeInsets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 4, left: 28, bottom: 4, right: 28)
        }
        set {
            super.titleEdgeInsets = newValue
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let s = super.intrinsicContentSize
        
        return CGSize(width: s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      height: s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom)
    }
    
    // MARK: - Private instance methods
    
    private func setup() {
        self.backgroundColor = self.tintColor
        self.layer.cornerRadius = 4
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22)
        
        addTarget(self, action: #selector(scaleToSmall), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(scaleAnimation), for: .touchUpInside)
        addTarget(self, action: #selector(scaleToDefault), for: .touchDragExit)
    }
    
    // MARK: - Animations
    
    @objc private func scaleToSmall() {
        if let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY) {
            scaleAnimation.toValue = CGSize(width: 0.95, height: 0.95)
            
            self.layer.pop_add(scaleAnimation, forKey: "layerScaleSmallAnimation")
        }
    }
    
    @objc private func scaleAnimation() {
        if let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY) {
            scaleAnimation.velocity = CGSize(width: 3, height: 3)
            scaleAnimation.toValue = CGSize(width: 1, height: 1)
            scaleAnimation.springBounciness = 18
            
            self.layer.pop_add(scaleAnimation, forKey: "layerScaleSpringAnimation")
        }
    }
    
    @objc private func scaleToDefault() {
        if let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY) {
            scaleAnimation.toValue = CGSize(width: 1, height: 1)
            
            self.layer.pop_add(scaleAnimation, forKey: "layerScaleDefaultAnimation")
        }
    }
}

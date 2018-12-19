//
//  FoldingView.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

@objc enum LayerSection: Int
{
    case top
    case bottom
}

class FoldingView: UIView
{
    var image: UIImage!
    var topView: UIImageView!
    var backView: UIImageView!
    var bottomShadowLayer: CAGradientLayer!
    var topShadowLayer: CAGradientLayer!
    var initialLocation: CGFloat!
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        self.image = image
        self.addBottomView()
        self.addTopView()
        self.addGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addTopView() {
        let image: UIImage = self.imageForSection(.top, withImage: self.image)
        
        let rect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.midY)
        self.topView = UIImageView(frame: rect)
        self.topView.image = image
        self.topView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.topView.layer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.topView.layer.transform = self.transform3D()
        self.topView.layer.mask = self.maskForSection(.top, withRect: self.topView.bounds)
        self.topView.isUserInteractionEnabled = true
        self.topView.contentMode = .scaleAspectFill
        
        self.backView = UIImageView(frame: self.topView.bounds)
        self.backView.image = image.blurred
        self.backView.alpha = 0.0
        
        topShadowLayer = CAGradientLayer()
        topShadowLayer.frame = self.topView.bounds
        topShadowLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        topShadowLayer.opacity = 0
        
        self.topView.addSubview(self.backView)
        self.topView.layer.addSublayer(self.topShadowLayer)
        self.addSubview(topView)
    }
    
    private func addBottomView() {
        let image: UIImage = self.imageForSection(.bottom, withImage: self.image)
        
        let rect = CGRect(x: 0, y: self.bounds.midY, width: self.bounds.width, height: self.bounds.midY)
        let bottomView: UIImageView = UIImageView(frame: rect)
        bottomView.image = image
        bottomView.contentMode = .scaleAspectFill
        bottomView.layer.mask = self.maskForSection(.bottom, withRect: bottomView.bounds)
        
        bottomShadowLayer = CAGradientLayer()
        bottomShadowLayer.frame = bottomView.bounds
        bottomShadowLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        bottomShadowLayer.opacity = 0
        
        bottomView.layer.addSublayer(bottomShadowLayer)
        self.addSubview(bottomView)
    }
    
    private func addGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(poke))
        
        self.topView.addGestureRecognizer(panGestureRecognizer)
        self.topView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func poke() {
        self.rotateToOriginWithVelocity(5)
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let location: CGPoint = recognizer.location(in: self)
        
        if (recognizer.state == .began) {
            self.initialLocation = location.y
        }
        
        let rotation: CGFloat = self.topView.layer.value(forKeyPath: "transform.rotation.x") as! CGFloat
        if (rotation < -.pi/2) {
            self.backView.alpha = 1.0
            
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            self.topShadowLayer.opacity = 0.0
            self.bottomShadowLayer.opacity = Float((location.y - self.initialLocation) / (self.bounds.height - self.initialLocation))
            CATransaction.commit()
        } else {
            self.backView.alpha = 0.0

            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            let opacity: CGFloat = (location.y - self.initialLocation) / (self.bounds.height - self.initialLocation)
            self.bottomShadowLayer.opacity = Float(opacity)
            self.topShadowLayer.opacity = Float(opacity)
            CATransaction.commit()
        }
        
        if (self.isLocation(location, inView: self)) {
            let conversionFactor: CGFloat = -.pi / (self.bounds.height - self.initialLocation)
            
            if let rotationAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotationX) {
                rotationAnimation.duration = 0.01
                rotationAnimation.toValue = (location.y - self.initialLocation) * conversionFactor
                
                self.topView.layer.pop_add(rotationAnimation, forKey: "rotationAnimation")
            }
        } else {
            recognizer.isEnabled = false
            recognizer.isEnabled = true
        }
        
        if (recognizer.state == .ended || recognizer.state == .cancelled) {
            self.rotateToOriginWithVelocity(0)
        }
    }
    
    private func rotateToOriginWithVelocity(_ velocity: CGFloat) {
        if let rotationAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotationX) {
            if (velocity > 0) {
                rotationAnimation.velocity = velocity
            }
            rotationAnimation.springBounciness = 18
            rotationAnimation.dynamicsMass = 2
            rotationAnimation.dynamicsTension = 200
            rotationAnimation.toValue = 0
            rotationAnimation.delegate = self
            
            self.topView.layer.pop_add(rotationAnimation, forKey: "rotationAnimation")
        }
    }
    
    private func transform3D() -> CATransform3D {
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = 2.5 / -2000
        return transform
    }
    
    private func isLocation(_ location: CGPoint, inView view: UIView) -> Bool {
        if ((location.x > 0 && location.x < self.bounds.width) &&
            (location.y > 0 && location.y < self.bounds.height)) {
            return true
        }
        
        return false
    }
    
    private func imageForSection(_ section: LayerSection, withImage image: UIImage) -> UIImage {
        var rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height / 2)
        if (section == .bottom) {
            rect.origin.y = image.size.height / 2
        }
        
        let imgRef = image.cgImage?.cropping(to: rect)
        let imagePart = UIImage(cgImage: imgRef!)
        return imagePart
    }
    
    private func maskForSection(_ section: LayerSection, withRect rect: CGRect) -> CAShapeLayer {
        let layerMask = CAShapeLayer()
        let corners = UIRectCorner(rawValue: section == .top ? 3 : 12)
        
        let size = CGSize(width: 5, height: 5)
        layerMask.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: size).cgPath
        return layerMask
    }
}

extension FoldingView: POPAnimationDelegate
{
    func pop_animationDidApply(_ anim: POPAnimation!) {
        let currentValue: CGFloat = anim.value(forKey: "currentValue") as! CGFloat
        
        if (currentValue > -.pi/2) {
            self.backView.alpha = 0
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            self.bottomShadowLayer.opacity = Float(-currentValue / .pi)
            self.topShadowLayer.opacity = Float(-currentValue / .pi)
            CATransaction.commit()
        }
    }
}

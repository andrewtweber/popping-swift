//
//  ImageViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

struct AnimationInfo {
    var progress: CGFloat
    var toValue: CGFloat
    var currentValue: CGFloat
}

class ImageViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addImageView()
    }
    
    private func addImageView() {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        let width = self.view.bounds.width - 20
        let height = width * 0.75
        let imageView = ImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.center = self.view.center
        imageView.setImage(UIImage(named: "boat.jpg")!)
        imageView.addTarget(self, action: #selector(touchDown), for: .touchDown)
        imageView.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        imageView.addGestureRecognizer(recognizer)
        
        self.view.addSubview(imageView)
        self.scaleDownView(imageView)
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        self.scaleDownView(recognizerView)
        
        let translation: CGPoint = recognizer.translation(in: self.view)
        recognizerView.center = CGPoint(x: recognizerView.center.x + translation.x,
                                        y: recognizerView.center.y + translation.y)
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        
        if (recognizer.state == .ended) {
            let velocity: CGPoint = recognizer.velocity(in: self.view)
            
            if let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPosition) {
                positionAnimation.velocity = velocity
                positionAnimation.dynamicsTension = 10
                positionAnimation.dynamicsFriction = 1
                positionAnimation.springBounciness = 12
                recognizerView.layer.pop_add(positionAnimation, forKey: "layerPositionAnimation")
            }
        }
    }
    
    @objc private func touchDown(_ sender: UIControl) {
        self.pauseAllAnimations(true, forLayer: sender.layer)
    }
    
    @objc private func touchUpInside(_ sender: UIControl) {
        guard let animationInfo = self.animationInfoForLayer(sender.layer) else {
            return
        }
        let hasAnimations: Bool = (sender.layer.pop_animationKeys().count > 0)
        
        if (hasAnimations && animationInfo.progress < 0.98) {
            self.pauseAllAnimations(false, forLayer: sender.layer)
            return
        }
        
        sender.layer.pop_removeAllAnimations()
        if (animationInfo.toValue == 1 || sender.layer.affineTransform().a == 1) {
            self.scaleDownView(sender)
            return
        }
        self.scaleUpView(sender)
    }
    
    func animationInfoForLayer(_ layer: CALayer) -> AnimationInfo? {
        guard let animation: POPSpringAnimation = layer.pop_animation(forKey: "scaleAnimation") as? POPSpringAnimation else {
            return nil
        }
        let toValue: CGPoint = animation.toValue as! CGPoint
        let currentValue: CGPoint = animation.value(forKey: "currentValue") as! CGPoint
        
        let minX: CGFloat = min(toValue.x, currentValue.x)
        let maxX: CGFloat = max(toValue.x, currentValue.x)
        
        let info = AnimationInfo(
            progress: minX / maxX,
            toValue: toValue.x,
            currentValue: currentValue.x
        )
        return info
    }
    
    func pauseAllAnimations(_ pause: Bool, forLayer layer: CALayer)
    {
        // TODO for some reason layer is nil when called from touchDown
        if (pause == true) {
            return
        }
        for key in layer.pop_animationKeys() {
            let animation: POPAnimation = layer.pop_animation(forKey: key as? String) as! POPAnimation
            animation.isPaused = pause
        }
    }
    
    func scaleUpView(_ view: UIView) {
        if let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPosition) {
            positionAnimation.toValue = self.view.center
            view.layer.pop_add(positionAnimation, forKey: "layerPositionAnimation")
        }
        
        if let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY) {
            scaleAnimation.toValue = CGSize(width: 1, height: 1)
            scaleAnimation.springBounciness = 10
            view.layer.pop_add(scaleAnimation, forKey: "scaleAnimation")
        }
    }
    
    func scaleDownView(_ view: UIView) {
        if let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY) {
            scaleAnimation.toValue = CGSize(width: 0.5, height: 0.5)
            scaleAnimation.springBounciness = 10
            view.layer.pop_add(scaleAnimation, forKey: "scaleAnimation")
        }
    }
}

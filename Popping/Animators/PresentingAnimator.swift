//
//  PresentingAnimator.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class PresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        guard let fromVC = transitionContext.viewController(forKey: .from), let fromView = fromVC.view else {
            return
        }
        fromView.tintAdjustmentMode = .dimmed
        fromView.isUserInteractionEnabled = false
        
        // Tinted background
        let dimmingView: UIView = UIView(frame: fromView.bounds)
        dimmingView.backgroundColor = .black
        dimmingView.layer.opacity = 0.0
        
        guard let toVC = transitionContext.viewController(forKey: .to), let toView = toVC.view else {
            return
        }
        let width = transitionContext.containerView.bounds.width
        let height = transitionContext.containerView.bounds.height
        let centerX = transitionContext.containerView.center.x
        let centerY = transitionContext.containerView.center.y
        toView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        toView.center = CGPoint(x: centerX, y: -centerY)
        
        transitionContext.containerView.addSubview(dimmingView)
        transitionContext.containerView.addSubview(toView)
        
        // Animations
        // Move from above screen to vertically centered
        if let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            positionAnimation.toValue = transitionContext.containerView.center.y
            positionAnimation.springBounciness = 10
            positionAnimation.completionBlock = {(animation, finished) in
                transitionContext.completeTransition(true)
            }
            
            toView.layer.pop_add(positionAnimation, forKey: "positionAnimation")
        }
        
        // Spring between 1.2 to 1.4 scale
        if let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY) {
            scaleAnimation.springBounciness = 20
            scaleAnimation.fromValue = CGPoint(x: 1.2, y: 1.4)
            
            toView.layer.pop_add(scaleAnimation, forKey: "scaleAnimation")
        }
        
        // Fade in tinted background
        if let opacityAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity) {
            opacityAnimation.toValue = 0.4
            
            dimmingView.layer.pop_add(opacityAnimation, forKey: "opacityAnimation")
        }
    }
}

//
//  DismissingAnimator.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class DismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        toVC.view.tintAdjustmentMode = .normal
        toVC.view.isUserInteractionEnabled = true
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        var dimmingView: UIView?
        for view in transitionContext.containerView.subviews where (view.layer.opacity < 1) {
            dimmingView = view
            break
        }
        
        // Animations
        // Fade out tinted background
        if let dimmingView = dimmingView, let opacityAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity) {
            opacityAnimation.toValue = 0
            
            dimmingView.layer.pop_add(opacityAnimation, forKey: "opacityAnimation")
        }
        
        // Move modal up screen
        if let offscreenAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY) {
            offscreenAnimation.toValue = -fromVC.view.layer.position.y
            offscreenAnimation.completionBlock = {(animation, finished) in
                transitionContext.completeTransition(true)
            }
            
            fromVC.view.layer.pop_add(offscreenAnimation, forKey: "offscreenAnimation")
        }
    }
}

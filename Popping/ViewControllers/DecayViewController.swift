//
//  DecayViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class DecayViewController: UIViewController
{
    var dragView: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addDragView()
    }
    
    private func addDragView() {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        self.dragView = UIControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.dragView.center = self.view.center
        self.dragView.layer.cornerRadius = self.dragView.bounds.width / 2
        self.dragView.backgroundColor = .customBlue
        self.dragView.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.dragView.addGestureRecognizer(recognizer)
        
        self.view.addSubview(self.dragView)
    }
    
    @objc private func touchDown(_ sender: UIControl) {
        sender.layer.pop_removeAllAnimations()
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        let translation: CGPoint = recognizer.translation(in: self.view)
        recognizerView.center = CGPoint(x: recognizerView.center.x + translation.x,
                                        y: recognizerView.center.y + translation.y)
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        
        if (recognizer.state == .ended) {
            let velocity: CGPoint = recognizer.velocity(in: self.view)
            
            if let positionAnimation = POPDecayAnimation(propertyNamed: kPOPLayerPosition) {
                positionAnimation.delegate = self
                positionAnimation.velocity = velocity
                recognizerView.layer.pop_add(positionAnimation, forKey: "layerPositionAnimation")
            }
        }
    }
}

extension DecayViewController: POPAnimationDelegate
{
    func pop_animationDidApply(_ anim: POPAnimation!) {
        let isDragViewOutsideOfSuperView: Bool = !self.view.frame.contains(self.dragView.frame)
        
        if (isDragViewOutsideOfSuperView) {
            let currentVelocity: CGPoint = anim.value(forKey: "velocity") as! CGPoint
            let velocity: CGPoint = CGPoint(x: currentVelocity.x, y: -currentVelocity.y)
            
            if let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPosition) {
                positionAnimation.velocity = velocity
                positionAnimation.toValue = self.view.center
                self.dragView.layer.pop_add(positionAnimation, forKey: "layerPositionAnimation")
            }
        }
    }
}

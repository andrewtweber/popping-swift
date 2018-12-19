//
//  PaperButtonViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class PaperButtonViewController: UIViewController
{
    var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addBarButton()
        self.addTitleLabel()
    }
    
    // MARK: - Private instance methods
    
    private func addBarButton() {
        let button = PaperButton()
        button.addTarget(self, action: #selector(animateTitleLabel), for: .touchUpInside)
        button.tintColor = .customBlue
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    private func addTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont(name: "Avenir-Light", size: 26)
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .customGray
        self.setTitleLabel()
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.titleLabel)
        
        let views: [String: Any] = [
            "titleLabel": self.titleLabel,
        ]
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: [], metrics: nil, views: views)
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-(80)-[titleLabel]", options: [], metrics: nil, views: views)
        )
    }
    
    @objc func animateTitleLabel(_ sender: Any) {
        let toValue: CGFloat = self.view.bounds.midX
        
        // TODO: on screen animation is not springy
        guard let onscreenAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX) else {
            return
        }
        onscreenAnimation.toValue = toValue
        onscreenAnimation.springBounciness = 10
        
        guard let offscreenAnimation = POPBasicAnimation.easeIn() else {
            return
        }
        offscreenAnimation.property = POPAnimatableProperty.property(withName: kPOPLayerPositionX) as? POPAnimatableProperty
        offscreenAnimation.toValue = -toValue
        offscreenAnimation.duration = 0.2
            
        offscreenAnimation.completionBlock = {
            (anim, finished) -> Void in
                
            self.setTitleLabel()
            self.titleLabel.layer.pop_add(onscreenAnimation, forKey: "onscreenAnimation")
        }
        self.titleLabel.layer.pop_add(offscreenAnimation, forKey: "offscreenAnimation")
    }
    
    private func setTitleLabel() {
        var title = "List"
        if (self.titleLabel.text == title) {
            title = "Menu"
        }
        self.titleLabel.text = title
    }
}

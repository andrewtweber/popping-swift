//
//  ButtonViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop
import UIKit

class ButtonViewController: UIViewController
{
    var errorLabel: UILabel!
    var button: FlatButton!
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addButton()
        self.addLabel()
        self.addActivityIndicatorView()
    }
    
    // MARK: - Private instance methods
    
    private func addButton() {
        self.button = FlatButton()
        self.button.backgroundColor = .customBlue
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.setTitle("Log in", for: .normal)
        self.button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        self.view.addSubview(self.button)
        
        self.view.addConstraint(
            NSLayoutConstraint(item: self.button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        )
        self.view.addConstraint(
            NSLayoutConstraint(item: self.button, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        )
    }
    
    private func addLabel() {
        self.errorLabel = UILabel()
        self.errorLabel.font = UIFont(name: "Avenir-Light", size: 18)
        self.errorLabel.textColor = .customRed
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.text = "Just a serious login error."
        self.errorLabel.textAlignment = .center
        self.view.insertSubview(self.errorLabel, belowSubview: self.button)
        
        self.view.addConstraint(
            NSLayoutConstraint(item: self.errorLabel, attribute: .centerX, relatedBy: .equal, toItem: self.button, attribute: .centerX, multiplier: 1, constant: 0)
        )
        self.view.addConstraint(
            NSLayoutConstraint(item: self.errorLabel, attribute: .centerY, relatedBy: .equal, toItem: self.button, attribute: .centerY, multiplier: 1, constant: self.button.intrinsicContentSize.height)
        )
        
        self.errorLabel.layer.opacity = 0
    }
    
    private func addActivityIndicatorView() {
        self.activityIndicatorView = UIActivityIndicatorView(style: .gray)
        let item: UIBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func touchUpInside(_ button: FlatButton) {
        self.hideLabel()
        self.activityIndicatorView.startAnimating()
        button.isUserInteractionEnabled = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicatorView.stopAnimating()
            self.shakeButton()
            self.showLabel()
        }
    }
    
    // MARK: - Animations
    
    func shakeButton() {
        if let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX) {
            positionAnimation.velocity = 2000
            positionAnimation.springBounciness = 20
            positionAnimation.completionBlock = {
                (anim, finished) -> Void in
                
                self.button.isUserInteractionEnabled = true
            }
            self.button.layer.pop_add(positionAnimation, forKey: "positionAnimation")
        }
    }
    
    func showLabel() {
        self.errorLabel.layer.opacity = 1
        
        if let layerScaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY) {
            layerScaleAnimation.springBounciness = 18
            layerScaleAnimation.toValue = CGSize(width: 1, height: 1)
            self.errorLabel.layer.pop_add(layerScaleAnimation, forKey: "layerScaleAnimation")
        }
        if let layerPositionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            layerPositionAnimation.toValue = self.button.layer.position.y + self.button.intrinsicContentSize.height
            layerPositionAnimation.springBounciness = 12
            self.errorLabel.layer.pop_add(layerPositionAnimation, forKey: "layerPositionAnimation")
        }
    }
    
    func hideLabel() {
        if let layerScaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY) {
            layerScaleAnimation.toValue = CGSize(width: 0.5, height: 0.5)
            self.errorLabel.layer.pop_add(layerScaleAnimation, forKey: "layerScaleAnimation")
        }
        if let layerPositionAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY) {
            layerPositionAnimation.toValue = self.button.layer.position.y
            self.errorLabel.layer.pop_add(layerPositionAnimation, forKey: "layerPositionAnimation")
        }
    }
}

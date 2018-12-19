//
//  ModalViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController
{
    var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackgroundView()
        self.addDismissButton()
    }
    
    // MARK: - Private instance methods
    
    private func addBackgroundView() {
        self.backgroundView = UIView()
        self.backgroundView.layer.cornerRadius = 8
        self.backgroundView.backgroundColor = .customBlue
        self.view.addSubview(self.backgroundView)
        
        let width = UIScreen.main.bounds.width - 64
        let height = UIScreen.main.bounds.height - 240
        
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(
            NSLayoutConstraint(item: self.backgroundView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        )
        self.view.addConstraint(
            NSLayoutConstraint(item: self.backgroundView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        )
        self.view.addConstraint(
            NSLayoutConstraint(item: self.backgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        )
        self.view.addConstraint(
            NSLayoutConstraint(item: self.backgroundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        )
    }
    
    private func addDismissButton() {
        let dismissButton = UIButton(type: .system)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.tintColor = .white
        dismissButton.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        self.backgroundView.addSubview(dismissButton)
        
        let views: [String: Any] = [
            "dismissButton": dismissButton,
        ]
        
        self.view.addConstraint(
            NSLayoutConstraint(item: dismissButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:[dismissButton]-|", options: [], metrics: nil, views: views)
        )
    }
    
    @objc func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

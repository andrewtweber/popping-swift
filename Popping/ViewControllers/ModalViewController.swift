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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 8
        self.view.backgroundColor = .customBlue
        self.addDismissButton()
    }
    
    private func addDismissButton() {
        let dismissButton = UIButton(type: .system)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.tintColor = .white
        dismissButton.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        self.view.addSubview(dismissButton)
        
        //[self.view addConstraint:[NSLayoutConstraint constraintWithItem:dismissButton
//        attribute:NSLayoutAttributeCenterX
//        relatedBy:NSLayoutRelationEqual
//        toItem:self.view
//        attribute:NSLayoutAttributeCenterX
//        multiplier:1.f
//        constant:0.f]];
//
//        [self.view addConstraints:[NSLayoutConstraint
//        constraintsWithVisualFormat:@"V:[dismissButton]-|"
//        options:0
//        metrics:nil
//        views:NSDictionaryOfVariableBindings(dismissButton)]];
    }
    
    @objc func dismiss(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

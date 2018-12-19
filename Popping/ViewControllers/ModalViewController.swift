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
    
    @objc func dismiss(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

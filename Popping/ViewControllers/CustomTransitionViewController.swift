//
//  CustomTransitionViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class CustomTransitionViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addPresentButton()
    }
    
    private func addPresentButton() {
        let presentButton = UIButton(type: .system)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.setTitle("Present Modal View Controller", for: .normal)
        presentButton.addTarget(self, action: #selector(showModal), for: .touchUpInside)
        self.view.addSubview(presentButton)
        
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
//            attribute:NSLayoutAttributeCenterX
//            relatedBy:NSLayoutRelationEqual
//            toItem:self.view
//            attribute:NSLayoutAttributeCenterX
//            multiplier:1.f
//            constant:0.f]];
//
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
//            attribute:NSLayoutAttributeCenterY
//            relatedBy:NSLayoutRelationEqual
//            toItem:self.view
//            attribute:NSLayoutAttributeCenterY
//            multiplier:1.f
//            constant:0.f]];
    }
    
    @objc func showModal(sender: Any) {
        let modalViewController = ModalViewController()
        modalViewController.transitioningDelegate = self
        modalViewController.modalPresentationStyle = .custom
        
        self.navigationController?.present(modalViewController, animated: true, completion: nil)
    }
}

extension CustomTransitionViewController: UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentingAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissingAnimator()
    }
}

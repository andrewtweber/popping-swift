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
    
    // MARK: - Private instance methods
    
    private func addPresentButton() {
        let presentButton = UIButton(type: .system)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.setTitle("Present Modal View Controller", for: .normal)
        presentButton.addTarget(self, action: #selector(showModal), for: .touchUpInside)
        self.view.addSubview(presentButton)
        
        self.view.addConstraint(
            NSLayoutConstraint(item: presentButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        )
        self.view.addConstraint(
            NSLayoutConstraint(item: presentButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        )
    }
    
    @objc func showModal(_ sender: Any) {
        let modalViewController = ModalViewController()
        modalViewController.transitioningDelegate = self
        modalViewController.modalPresentationStyle = .custom
        
        self.navigationController?.present(modalViewController, animated: true, completion: nil)
    }
}

// MARK: - Transitioning delegate

extension CustomTransitionViewController: UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentingAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissingAnimator()
    }
}

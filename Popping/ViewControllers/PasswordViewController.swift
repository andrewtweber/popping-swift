//
//  PasswordViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController
{
    var passwordTextField: UITextField!
    var passwordStrengthIndicatorView: PasswordStrengthIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addPasswordTextField()
        self.addPasswordStrengthView()
    }
    
    // MARK: - Private instance methods
 
    private func addPasswordTextField()
    {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        self.passwordTextField = UITextField()
        self.passwordTextField.leftView = leftPaddingView
        self.passwordTextField.leftViewMode = .always
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.layer.cornerRadius = 2
        self.passwordTextField.placeholder = "Enter a Password"
        self.passwordTextField.becomeFirstResponder()
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.view.addSubview(self.passwordTextField)
        
        let views: [String: Any] = [
            "passwordTextField": self.passwordTextField,
        ]
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[passwordTextField]-|", options: [], metrics: nil, views: views)
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-(88)-[passwordTextField(==36)]", options: [], metrics: nil, views: views)
        )
    }
    
    private func addPasswordStrengthView()
    {
        self.passwordStrengthIndicatorView = PasswordStrengthIndicatorView()
        self.view.addSubview(self.passwordStrengthIndicatorView)
        
        let views: [String: Any] = [
            "passwordTextField": self.passwordTextField,
            "passwordStrengthIndicatorView": self.passwordStrengthIndicatorView,
        ]
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[passwordStrengthIndicatorView]-|", options: [], metrics: nil, views: views)
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:[passwordTextField]-[passwordStrengthIndicatorView(==10)]", options: [], metrics: nil, views: views)
        )
    }
    
    // MARK: - Event handlers
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        if (sender.text!.count < 1) {
            self.passwordStrengthIndicatorView.status = .none
            return
        }
        
        if (sender.text!.count < 5) {
            self.passwordStrengthIndicatorView.status = .weak
            return
        }
        
        if (sender.text!.count < 10) {
            self.passwordStrengthIndicatorView.status = .fair
            return
        }
        
        self.passwordStrengthIndicatorView.status = .strong
    }
}

//
//  PasswordStrengthIndicatorView.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

@objc enum PasswordStrengthIndicatorViewStatus: Int
{
    case none
    case weak
    case fair
    case strong
}

class PasswordStrengthIndicatorView: UIView
{
    var status: PasswordStrengthIndicatorViewStatus = .none
    var indicatorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0, alpha: 0.05)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 2
        self.addIndicatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setStatus(_ status: PasswordStrengthIndicatorViewStatus) {
        if (status == self.status) {
            return
        }
        
        self.status = status
        self.animateIndicatorViewToStatus(status)
    }
    
    func animateIndicatorViewToStatus(_ status: PasswordStrengthIndicatorViewStatus) {
        let constraints = self.constraints.enumerated()
        for constraint in constraints {
            if (constraint.element.firstAttribute == .width) {
                self.removeConstraint(constraint.element)
                break
            }
        }
        
        self.addConstraint(
            NSLayoutConstraint(item: self.indicatorView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: self.multiplierForStatus(status), constant: 0)
        )
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
                self.layoutIfNeeded()
                self.indicatorView.backgroundColor = self.colorForStatus(status)
        }, completion: nil)
    }
    
    func multiplierForStatus(_ status: PasswordStrengthIndicatorViewStatus) -> CGFloat {
        switch (status) {
            case .weak:
                return 0.33
            case .fair:
                return 0.66
            case .strong:
                return 1
            default:
                return 0
        }
    }
    
    func colorForStatus(_ status: PasswordStrengthIndicatorViewStatus) -> UIColor {
        switch (status) {
            case .weak:
                return .customRed
            case .fair:
                return .customYellow
            case .strong:
                return .customGreen
            default:
                return .white
        }
    }
    
    private func addIndicatorView() {
        self.indicatorView = UIView()
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorView.layer.cornerRadius = self.layer.cornerRadius
        self.addSubview(self.indicatorView)
        
        self.addConstraint(
            NSLayoutConstraint(item: self.indicatorView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
        )
        self.addConstraint(
            NSLayoutConstraint(item: self.indicatorView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: self.multiplierForStatus(self.status), constant: 0)
        )
        self.addConstraint(
            NSLayoutConstraint(item: self.indicatorView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        )
        self.addConstraint(
            NSLayoutConstraint(item: self.indicatorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        )
    }
}

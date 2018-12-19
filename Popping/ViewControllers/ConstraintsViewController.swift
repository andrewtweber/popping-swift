//
//  ConstraintsViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/19/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class ConstraintsViewController: UIViewController
{
    var yellowView: UIView!
    var greenView: UIView!
    var blueView: UIView!
    var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addBarButton()
        self.addViews()
        self.updateConstraints(nil)
    }
    
    private func addBarButton() {
        let item = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(updateConstraints))
        self.navigationItem.rightBarButtonItem = item
    }
    
    private func addViews() {
        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = self.view.backgroundColor
        self.view.addSubview(self.contentView)
        
        let views: [String: Any] = [
            "contentView": contentView,
        ]
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [.directionLeadingToTrailing], metrics: nil, views: views)
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [.directionLeadingToTrailing], metrics: nil, views: views)
        )
        
        self.yellowView = UIView()
        self.yellowView.backgroundColor = .customYellow
        self.yellowView.translatesAutoresizingMaskIntoConstraints = false
        self.yellowView.layer.cornerRadius = 4
        
        self.greenView = UIView()
        self.greenView.backgroundColor = .customGreen
        self.greenView.translatesAutoresizingMaskIntoConstraints = false
        self.greenView.layer.cornerRadius = 4
        
        self.blueView = UIView()
        self.blueView.backgroundColor = .customBlue
        self.blueView.translatesAutoresizingMaskIntoConstraints = false
        self.blueView.layer.cornerRadius = 4
        
        self.contentView.addSubview(self.yellowView)
        self.contentView.addSubview(self.greenView)
        self.contentView.addSubview(self.blueView)
    }
    
    @objc func updateConstraints(_ sender: Any?) {
        self.contentView.layoutIfNeeded()
        self.contentView.removeConstraints(self.contentView.constraints)
        
        let views: [String: Any] = [
            "yellowView": self.yellowView,
            "greenView": self.greenView,
            "blueView": self.blueView,
        ]
        let viewNames = views.keys.shuffled()
        
        let firstViewKey: String = viewNames[0]
        let secondViewKey: String = viewNames[1]
        let thirdViewKey: String = viewNames[2]
        
        let horizontalFormat = "H:|-(20)-[\(firstViewKey)]-(20)-|"
        let additionalHorizontalFormat = "H:|-(20)-[\(secondViewKey)]-(20)-[\(thirdViewKey)(==\(secondViewKey))]-(20)-|"
        
        let verticalFormat = "V:|-(88)-[\(firstViewKey)]-(20)-[\(secondViewKey)(==\(firstViewKey))]-(20)-|"
        let additionalVerticalFormat = "V:|-(88)-[\(firstViewKey)]-(20)-[\(thirdViewKey)(==\(firstViewKey))]-(20)-|"
        
        self.contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: horizontalFormat, options: [], metrics: nil, views: views)
        )
        self.contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: additionalHorizontalFormat, options: [.alignAllTop], metrics: nil, views: views)
        )
        self.contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: verticalFormat, options: [], metrics: nil, views: views)
        )
        self.contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: additionalVerticalFormat, options: [], metrics: nil, views: views)
        )
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
                self.contentView.layoutIfNeeded()
            }, completion: nil)
    }
}

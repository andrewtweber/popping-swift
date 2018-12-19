//
//  MenuTableViewCell.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import pop

class MenuTableViewCell: UITableViewCell
{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.textColor = .customGray
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.textLabel?.font = UIFont(name: "Avenir-Light", size: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if (self.isHighlighted) {
            if let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY) {
                scaleAnimation.duration = 0.1
                scaleAnimation.toValue = CGPoint(x: 0.95, y: 0.95)
                
                self.textLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            }
        } else {
            if let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY) {
                scaleAnimation.toValue = CGPoint(x: 1, y: 1)
                scaleAnimation.velocity = CGPoint(x: 2, y: 2)
                scaleAnimation.springBounciness = 20
                
                self.textLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            }
        }
    }
}

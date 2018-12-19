//
//  UIColor.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    class var customGray: UIColor {
        return UIColor(red: 84, green: 84, blue: 84)
    }
    
    class var customRed: UIColor {
        return UIColor(red: 231, green: 76, blue: 60)
    }
    
    class var customYellow: UIColor {
        return UIColor(red: 241, green: 196, blue: 15)
    }
    
    class var customGreen: UIColor {
        return UIColor(red: 46, green: 204, blue: 113)
    }
    
    class var customBlue: UIColor {
        return UIColor(red: 52, green: 152, blue: 219)
    }
}

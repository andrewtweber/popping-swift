//
//  ImageView.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class ImageView: UIControl
{
    var imageView: UIImageView!
    var image: UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
        self.image = image
    }
}

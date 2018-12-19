//
//  UIImage.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

extension UIImage
{
    var blurred: UIImage {
        let context = CIContext()
        guard let inputImage = CIImage(image: self), let filter = CIFilter(name: "CIGaussianBlur") else {
            return self
        }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(10, forKey: kCIInputRadiusKey)
        
        guard let result: CIImage = filter.outputImage else {
            return self
        }
        guard let cgImage: CGImage = context.createCGImage(result, from: inputImage.extent) else {
            return self
        }
        let returnImage: UIImage = UIImage(cgImage: cgImage)
        return returnImage
    }
}

//
//  CircleViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController
{
    var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addCircleView()
        self.addSlider()
    }
    
    // MARK: - Private instance methods
    
    private func addCircleView() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.circleView = CircleView(frame: frame)
        self.circleView.strokeColor = .customBlue
        self.circleView.center = self.view.center
        
        self.view.addSubview(self.circleView)
    }
    
    private func addSlider() {
        let slider = UISlider()
        slider.value = 0.7
        slider.tintColor = .customBlue
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        self.view.addSubview(slider)
        
        let views: [String: Any] = [
            "slider": slider,
            "circleView": self.circleView,
        ]
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:[circleView]-(40)-[slider]", options: [], metrics: nil, views: views)
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[slider]-|", options: [], metrics: nil, views: views)
        )
        
        self.circleView.setStrokeEnd(CGFloat(slider.value), animated: false)
    }
    
    @objc private func sliderChanged(_ slider: UISlider) {
        self.circleView.setStrokeEnd(CGFloat(slider.value), animated: true)
    }
}

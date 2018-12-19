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
        
        // NSDictionary *views = NSDictionaryOfVariableBindings(slider, _circleView);
        
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_circleView]-(40)-[slider]"
//            options:0
//            metrics:nil
//            views:views]];
//
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[slider]-|"
//            options:0
//            metrics:nil
//            views:views]];
//        [self.circleView setStrokeEnd:slider.value animated:NO];
    }
    
    @objc private func sliderChanged(slider: UISlider) {
        self.circleView.setStrokeEnd(CGFloat(slider.value), animated: true)
    }
}

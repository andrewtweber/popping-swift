//
//  FoldingViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class FoldingViewController: UIViewController
{
    var foldView: FoldingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addFoldView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.foldView.poke()
    }
    
    // MARK: - Private instance methods
    
    private func addFoldView() {
        let padding: CGFloat = 30
        let width: CGFloat = self.view.bounds.width - (padding * 2)
        let frame: CGRect = CGRect(x: 0, y: 0, width: width, height: width)
        
        self.foldView = FoldingView(frame: frame, image: UIImage(named: "winnie.jpg")!)
        self.foldView.center = self.view.center
        self.view.addSubview(self.foldView)
    }
}

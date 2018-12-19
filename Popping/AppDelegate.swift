//
//  AppDelegate.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let animationsListViewController = AnimationsListViewController()
        let navigationController = UINavigationController(rootViewController: animationsListViewController)
        
        self.window?.rootViewController = navigationController
        self.window?.backgroundColor = .white
        self.window?.tintColor = .customBlue
        self.window?.makeKeyAndVisible()
        
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Avenir", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.customGray,
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        return true
    }
}

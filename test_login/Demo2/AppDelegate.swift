//
//  AppDelegate.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainController = MainViewController.instantiate()
        let navController = CustomNavigationController(rootViewController: mainController)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

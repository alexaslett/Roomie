//
//  AppDelegate.swift
//  Roomie
//
//  Created by Alex Aslett on 9/18/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navBarApperance = UINavigationBar.appearance()
        
        navBarApperance.tintColor = UIColor.tealBlue30
//        navBarApperance.barTintColor = UIColor.clear
        
        
        return true
    }
}


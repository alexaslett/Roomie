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
        let labelAppearance = UILabel.appearance()
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        
        navBarApperance.tintColor = UIColor.tealBlue30
        navBarApperance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.tealBlue30, NSAttributedStringKey.font: UIFont.titleFont]
        
        labelAppearance.font = UIFont.optimusPrincepsFont
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.tealBlue30, NSAttributedStringKey.font: UIFont.optimusPrincepsFont], for: .normal)
        
        return true
    }
}


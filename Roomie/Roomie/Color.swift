//
//  Color.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var tealBlue30: UIColor {
        return UIColor(hex: "7AB8BF")
    }
    
    class var customLightGrey10: UIColor {
        return UIColor(hex: "A3A09C")
    }
    
    class var ivoryWhite60: UIColor {
        return UIColor(hex: "F5F1ED")
    }
    
    class var postItNoteYellow: UIColor {
        return UIColor(hex: "FEEA9A")
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }
}

//
//  Font.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 10/2/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static var americanTypewriter: UIFont {
        guard let fontName = UIFont(name: "AmericanTypewriter", size: 20.0) else { return UIFont() }

        return fontName
    }
    
    static var titleFont: UIFont {
        guard let fontName = UIFont(name: "AmericanTypewriter", size: 30.0) else { return UIFont() }
        
        return fontName
    }
}

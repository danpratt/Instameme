//
//  AvailableFonts.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import UIKit

struct Settings {
    
    static let blueColor = UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
    
    var fontSize: CGFloat = 40.0
    var font: UIFont = UIFont(name: Fonts.impact.rawValue, size: 40.0)!
    var fontShouldBeBlack = false
    
    var textAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeWidthAttributeName: -3.0,
        ]
    
    var backgroundColor = blueColor
    
    var blackTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.white,
        NSForegroundColorAttributeName: UIColor.black,
        NSStrokeWidthAttributeName: -3.0,
    ]
    
    // Fonts
    enum Fonts: String {
        case impact = "Impact"
        case fun = "PartyLetPlain"
        case jedi = "Death Star"
    }
    
}

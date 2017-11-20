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
    var displayFont: UIFont = UIFont(name: Fonts.impact.rawValue, size: 17.0)!
    var fontShouldBeBlack = false
    
    var textAttributes: [String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0,
        ]
    
    var backgroundColor = blueColor
    
    var blackTextAttributes: [String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.white,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0,
    ]
    
    var funTextAttributesWhite: [String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.white,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.strokeWidth.rawValue: 0.0,
        ]
    
    var funTextAttributesBlack: [String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
        NSAttributedStringKey.strokeWidth.rawValue: 0.0,
        ]
    
    // Fonts
    enum Fonts: String {
        case impact = "Impact"
        case fun = "PartyLetPlain"
        case jedi = "Death Star"
    }
    
}

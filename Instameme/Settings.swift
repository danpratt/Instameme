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
    
    var fontSize: CGFloat = 40.0
    var font: UIFont = UIFont(name: Fonts.impact.rawValue, size: 40.0)!
    
    var textAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeWidthAttributeName: -3.0,
        ]
    
    // Fonts
    enum Fonts: String {
        case impact = "Impact"
        case fun = "Party LET"
        case jedi = "Death Star"
    }
    
    mutating func setFont(_ fontName: Fonts.RawValue, fontSize: CGFloat) {
        self.fontSize = fontSize
        self.font = UIFont(name: fontName, size: self.fontSize)!
    }
    
}

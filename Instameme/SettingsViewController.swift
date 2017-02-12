//
//  SettingsViewController.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/9/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var currentSettings: Settings!
    var newSettings: Settings!
    var topText: String!
    var bottomText: String!
    var image: UIImage?
    @IBOutlet weak var selectFontText: UILabel!
    var font: UIFont?
    
    // Segmented Controls
    @IBOutlet weak var fontSelection: UISegmentedControl!
    @IBOutlet weak var backgroundSelection: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.font = currentSettings.font
        newSettings = currentSettings
        selectFontText.font = font
        
        if font?.fontName == Settings.Fonts.impact.rawValue {
            fontSelection.selectedSegmentIndex = 0
        } else if font?.fontName == Settings.Fonts.fun.rawValue {
            fontSelection.selectedSegmentIndex = 1
        } else {
            fontSelection.selectedSegmentIndex = 2
        }
    }
    
    
    @IBAction func fontValueChanged(_ sender: UISegmentedControl) {
        let index = fontSelection.selectedSegmentIndex
        switch index {
        case 0:
            font = UIFont(name: Settings.Fonts.impact.rawValue, size: 40.0)!
        case 1:
            font = UIFont(name: Settings.Fonts.fun.rawValue, size: 40.0)!
        case 2:
            font = UIFont(name: Settings.Fonts.jedi.rawValue, size: 40.0)!
        default:
            print("This shouldn't happen")
        }
        
        selectFontText.font = font!
        newSettings.font = font!
    }
    
    
    @IBAction func backgroundColorChanged(_ sender: UISegmentedControl) {
        print("Background changed")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeVC = segue.destination as! InstamemeViewController
        if !(segue.identifier == "CancelSettings") {
            memeVC.settings = newSettings!
        }
        memeVC.topText = self.topText
        memeVC.bottomText = self.bottomText
        memeVC.memeImage = self.image
    }
}

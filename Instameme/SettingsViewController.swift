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
    
    // Font selection
    @IBOutlet weak var fontSelection: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func fontValueChanged(_ sender: Any) {
        let index = fontSelection.selectedSegmentIndex
        newSettings = currentSettings
        switch index {
        case 0:
            newSettings.font = UIFont(name: Settings.Fonts.impact.rawValue, size: 40.0)!
        case 1:
            newSettings.font = UIFont(name: Settings.Fonts.fun.rawValue, size: 40.0)!
        case 2:
            newSettings.font = UIFont(name: Settings.Fonts.jedi.rawValue, size: 40.0)!
        default:
            print("This shouldn't happen")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !(segue.identifier == "CancelSettings") {
            fontValueChanged(self)
            let memeVC = segue.destination as! InstamemeViewController
            memeVC.settings = newSettings!
            memeVC.topText = self.topText
            memeVC.bottomText = self.bottomText
            memeVC.memeImage = self.image
        }
    }
}

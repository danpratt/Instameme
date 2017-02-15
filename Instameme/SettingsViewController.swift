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
    var font: UIFont?
    var backgroundColor: UIColor?
    var shouldShareButtonBeVisible: Bool!
    
    // UI Elements
    @IBOutlet weak var fontSelection: UISegmentedControl!
    @IBOutlet weak var backgroundSelection: UISegmentedControl!
    @IBOutlet weak var selectFontLabel: UILabel!
    @IBOutlet weak var backgroundColorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        font = currentSettings.font
        backgroundColor = currentSettings.backgroundColor
        newSettings = currentSettings
        selectFontLabel.font = font
        view.backgroundColor = backgroundColor
        
        if currentSettings.fontShouldBeBlack {
            makeFontsBlack()
        } else {
            makeFontsWhite()
        }
        
        // Display initial configuration for segmented controls
        setupSegments()
    }
    
    func setupSegments() {
        // Set font segment
        if font?.fontName == Settings.Fonts.impact.rawValue {
            fontSelection.selectedSegmentIndex = 0
        } else if font?.fontName == Settings.Fonts.fun.rawValue {
            fontSelection.selectedSegmentIndex = 1
        } else {
            fontSelection.selectedSegmentIndex = 2
        }
        
        if backgroundColor == Settings.blueColor {
            backgroundSelection.selectedSegmentIndex = 0
        } else if backgroundColor == UIColor.black {
            backgroundSelection.selectedSegmentIndex = 1
        } else {
            backgroundSelection.selectedSegmentIndex = 2
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
        
        selectFontLabel.font = font!
        newSettings.font = font!
    }
    
    
    @IBAction func backgroundColorChanged(_ sender: UISegmentedControl) {
        let index = backgroundSelection.selectedSegmentIndex
        switch index {
        case 0:
            print("blue")
            if newSettings.fontShouldBeBlack {
                makeFontsWhite()
                newSettings.fontShouldBeBlack = false
            }
            backgroundColor = Settings.blueColor
        case 1:
            print("black")
            if newSettings.fontShouldBeBlack {
                makeFontsWhite()
                newSettings.fontShouldBeBlack = false
            }
            backgroundColor = UIColor.black
        case 2:
            print("white")
            backgroundColor = UIColor.white
            newSettings.fontShouldBeBlack = true
            makeFontsBlack()
        default:
            print("This shouldn't happen")
        }
        
        view.backgroundColor = backgroundColor
        newSettings.backgroundColor = backgroundColor!
    }
    
    func makeFontsBlack() {
        selectFontLabel.textColor = UIColor.black
        backgroundColorLabel.textColor = UIColor.black
        fontSelection.tintColor = UIColor.black
        backgroundSelection.tintColor = UIColor.black
    }
    
    func makeFontsWhite() {
        selectFontLabel.textColor = UIColor.white
        backgroundColorLabel.textColor = UIColor.white
        fontSelection.tintColor = UIColor.white
        backgroundSelection.tintColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeVC = segue.destination as! InstamemeViewController
        if !(segue.identifier == "CancelSettings") {
            memeVC.settings = newSettings!
        }
        memeVC.topText = topText
        memeVC.bottomText = bottomText
        memeVC.memeImage = image
        memeVC.shouldShareButtonBeVisible = shouldShareButtonBeVisible
    }
}

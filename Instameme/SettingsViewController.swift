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
        
        // Checks current settings and sets UI elements accordingly
        if currentSettings.fontShouldBeBlack {
            setFontsToColor(.black)
        } else {
            setFontsToColor(.white)
        }
        
        // Display initial configuration for segmented controls
        setupSegments()
    }
    
    // MARK: Functions
    
    // Sets segments up so they are selected on correct values
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
    
    // Sets fonts to specified color
    func setFontsToColor(_ color: UIColor) {
        selectFontLabel.textColor = color
        backgroundColorLabel.textColor = color
        fontSelection.tintColor = color
        backgroundSelection.tintColor = color
    }
    
    // MARK: IBActions
    
    // Font selector segment controls
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
    
    // background color segment controls
    @IBAction func backgroundColorChanged(_ sender: UISegmentedControl) {
        let index = backgroundSelection.selectedSegmentIndex
        switch index {
        case 0:
            if newSettings.fontShouldBeBlack {
                setFontsToColor(.white)
                newSettings.fontShouldBeBlack = false
            }
            backgroundColor = Settings.blueColor
        case 1:
            if newSettings.fontShouldBeBlack {
                setFontsToColor(.white)
                newSettings.fontShouldBeBlack = false
            }
            backgroundColor = UIColor.black
        case 2:
            backgroundColor = UIColor.white
            newSettings.fontShouldBeBlack = true
            setFontsToColor(.black)
        default:
            print("This shouldn't happen")
        }
        
        view.backgroundColor = backgroundColor
        newSettings.backgroundColor = backgroundColor!
    }
    
    // Called when user clicks done or cancel
    @IBAction func closeSettingsActions(_ sender: UIBarButtonItem) {
        let returnView = presentingViewController as! InstamemeViewController
        switch sender.tag {
        case 1:
            returnView.settings = newSettings
            returnView.setupMemeView()
            dismiss(animated: true, completion: nil)
        default:
            dismiss(animated: true, completion: nil)
        }
    }
}

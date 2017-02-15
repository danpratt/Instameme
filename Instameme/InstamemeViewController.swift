//
//  ViewController.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/7/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit

class InstamemeViewController: UIViewController, UITextFieldDelegate {
    
    // Text Field Outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // Navigation Toolbars
    @IBOutlet weak var pickerToolbar: UIToolbar!
    @IBOutlet weak var memeShareCancelBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // Image View
    @IBOutlet weak var memeImageView: UIImageView!
    
    // Camera button
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // Delegates
    let textFieldDelegate = MemeTextFieldDelegate()
    
    // Meme
    var meme: Meme?
    var memeImage: UIImage? = nil
    var topText = "TOP"
    var bottomText = "BOTTOM"
    var backgroundColor: UIColor?
    var shouldShareButtonBeVisible = false
    
    
    // Settings
    var settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Disable the camera button if user doesn't have one
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        // Setup Memes by calling function
        setupMemeView()
        
    }
    
    // Setup Empty State
    func setupMemeView() {
        
        // Do textfield prep work
        prepareAttributes()
        prepareTextField(textField: topTextField, containingText: topText)
        prepareTextField(textField: bottomTextField, containingText: bottomText)
        
        // setup image and background

        memeImageView.image = memeImage
        view.backgroundColor = settings.backgroundColor
        
        // Set sharebutton to enabled or disabled depending on if a picture has been selected
        shareButton.isEnabled = shouldShareButtonBeVisible
        
    }
    
    // MARK: TextField Setup
    
    // Setup textfield attributes
    func prepareAttributes () {
        // setup text attributes
        switch settings.fontShouldBeBlack {
        case true:
            if settings.font.fontName == Settings.Fonts.fun.rawValue {
                setupTextAttributes(withSettingsFor: settings.funTextAttributesBlack)
            } else {
                setupTextAttributes(withSettingsFor: settings.blackTextAttributes)
            }
        default:
            if settings.font.fontName == Settings.Fonts.fun.rawValue {
                setupTextAttributes(withSettingsFor: settings.funTextAttributesWhite)
            } else {
                setupTextAttributes(withSettingsFor: settings.textAttributes)
            }
        }
    }
    
    // Sets initial textfield delegate, allignment, fonts and text
    func prepareTextField(textField: UITextField, containingText text: String) {
        textField.font = settings.font
        textField.text = text
        textField.textAlignment = .center
        textField.delegate = textFieldDelegate
    }
    
    // Sets text attributes for top and bottom textfields
    func setupTextAttributes(withSettingsFor textSettings: [String: Any]) {
        topTextField.defaultTextAttributes = textSettings
        bottomTextField.defaultTextAttributes = textSettings
    }
    
    // MARK: Button Actions

    @IBAction func save(_ sender: Any) {
        // Create the meme
        meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImageView.image!, memedImage: generateMemedImage())
        
        let activityViewController = UIActivityViewController(activityItems: [(meme?.memedImage)! as UIImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        // Reseting doesn't update font choice
        // Might change this later
        topText = "TOP"
        bottomText = "BOTTOM"
        memeImage = nil
        backgroundColor = Settings.blueColor
        settings.backgroundColor = backgroundColor!
        settings.fontShouldBeBlack = false
        shouldShareButtonBeVisible = false
        setupMemeView()
    }
    
    @IBAction func pickFromLibrary(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: Generate the memed image
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        pickerToolbar.isHidden = true
        memeShareCancelBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar again
        pickerToolbar.isHidden = false
        memeShareCancelBar.isHidden = false
        
        return memedImage
    }
    
    
    // MARK: Prepare to view settings
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenSettings" {
            topText = topTextField.text ?? "TOP"
            bottomText = bottomTextField.text ?? "BOTTOM"
            memeImage = memeImageView.image
            let settingsController = segue.destination as! SettingsViewController
            settingsController.currentSettings = settings
            settingsController.topText = topText
            settingsController.bottomText = bottomText
            settingsController.image = memeImage
            settingsController.backgroundColor = backgroundColor
            settingsController.shouldShareButtonBeVisible = shouldShareButtonBeVisible
        }
    }
    
}


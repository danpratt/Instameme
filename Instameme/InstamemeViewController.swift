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
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
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
    var canCancel = false

    // MARK: ViewDidLoad
    override func viewDidLoad() {

        // Disable the camera button if user doesn't have one
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
    // Turn on notifications when the keyboard view will appear and setup the meme view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        setupMemeView()
        print(settings.backgroundColor)
        print(settings.font.fontName)
    }
    
    // Turn off notifications when keyboard will disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // Setup Empty State
    func setupMemeView() {
        
        if meme != nil {
            settings = (meme?.settings) ?? self.settings
        }
        
        // Do textfield prep work
        prepareAttributes()
        prepareTextField(textField: topTextField, containingText: topText)
        prepareTextField(textField: bottomTextField, containingText: bottomText)
        
        // setup image and background

        memeImageView.image = memeImage
        view.backgroundColor = settings.backgroundColor
        
        // Set sharebutton to enabled or disabled depending on if a picture has been selected
        shareButton.isEnabled = shouldShareButtonBeVisible
        // Set cancel button to enable or not depending on if coming from the memes collection views
        cancelButton.isEnabled = canCancel
        
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

    // Called when user taps on Share button
    @IBAction func share(_ sender: UIBarButtonItem) {
        // Generate a Meme
        let generatedMemeImage = generateMemedImage()
        
        // Present an activity controller that allows user to share meme
        let activityViewController = UIActivityViewController(activityItems: [(generatedMemeImage) as UIImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // only save the meme if the user performs some action, does not save if activityViewController is cancelled
        activityViewController.completionWithItemsHandler = {(activity, completed, items, error) in
            print("Going to save")
            if (completed) {
                let _ = self.save(generatedMemeImage)
            }
        }
        
        // Show controller to user
        present(activityViewController, animated: true, completion: nil)
    }

    // Resets the meme editor to defaults and sets up a new blank meme
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

        dismiss(animated: true, completion: nil)
    }
    
    // Called when user taps on either photos or camera buttons
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            pickImageFrom(.camera)
        default:
            pickImageFrom(.photoLibrary)
        }
    }
    
    // MARK: Pick an image
    
    // Displays image picker depending on source
    func pickImageFrom(_ source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }


    // MARK: Generate the memed image
    
    // Save the meme
    func save(_ memedImage: UIImage) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if meme == nil {
            meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImageView.image!, memedImage: memedImage, settings: settings)
        } else {
            meme?.topText = topTextField.text!
            meme?.bottomText = bottomTextField.text!
            meme?.originalImage = memeImageView.image!
            meme?.memedImage = memedImage
            meme?.settings = settings
        }
        appDelegate.memes.append(meme!)
        
        dismiss(animated: true, completion: nil)
    }
    
    // Generate a meme object
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
            print("Opening settings")
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


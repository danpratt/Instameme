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
    
    // Settings
    var settings = Settings()
    var settingsDidUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load, current values: ")
        print("Current Settings: \(settings)")
        print("Settings changed: \(settingsDidUpdate)")
        print("Top TextField contents: \(topTextField.text)")
        print("Bottom TextField contents: \(bottomTextField.text)")
        // Disable the camera button if user doesn't have one
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Setup Memes
//        if !settingsDidUpdate {
//            print("setting up meme view")
//            setupMemeView()
//        }
        setupMemeView()
        
    }
    
    // Setup Empty State
    func setupMemeView() {
        // setup text attributes
        topTextField.defaultTextAttributes = self.settings.textAttributes
        bottomTextField.defaultTextAttributes = self.settings.textAttributes
        topTextField.font = settings.font
        bottomTextField.font = settings.font
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        print("Setting up initial text")
        // setup initial states
        topTextField.text = self.topText
        bottomTextField.text = self.bottomText
        memeImageView.image = self.memeImage
        
        shareButton.isEnabled = false
        
        // set delegates
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        
//        for font in UIFont.familyNames {
//            print(font)
//        }

    }

    @IBAction func save(_ sender: Any) {
        // Create the meme
        self.meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImageView.image!, memedImage: generateMemedImage())
        
        let activityViewController = UIActivityViewController(activityItems: [(meme?.memedImage)! as UIImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
//        topTextField.text = ""
//        bottomTextField.text = ""
        settingsDidUpdate = false
        setupMemeView()
    }

    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.pickerToolbar.isHidden = true
        self.memeShareCancelBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar again
        self.pickerToolbar.isHidden = false
        self.memeShareCancelBar.isHidden = false
        
        return memedImage
    }
    
    // Actions from buttons
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
    
    // Prepare to view settings
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenSettings" {
            print("Preparing segue")
            topText = topTextField.text ?? "TOP"
            bottomText = bottomTextField.text ?? "BOTTOM"
            memeImage = memeImageView.image
            let settingsController = segue.destination as! SettingsViewController
            settingsController.currentSettings = self.settings
            settingsController.topText = self.topText
            settingsController.bottomText = self.bottomText
            settingsController.image = self.memeImage
        }
    }
    
}


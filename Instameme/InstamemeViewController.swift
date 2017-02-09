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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Disable the camera button if user doesn't have one
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Setup background
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        // Setup Memes
        setupMemeView()
        
        
            }
    
    // Setup Empty State
    func setupMemeView() {
        // setup text attributes
        topTextField.defaultTextAttributes = textFieldDelegate.textAttributes
        bottomTextField.defaultTextAttributes = textFieldDelegate.textAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        // setup initial states
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        memeImageView.image = nil
        shareButton.isEnabled = false
        
        // set delegates
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate

    }
    

    @IBAction func save(_ sender: Any) {
        // Create the meme
        self.meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImageView.image!, memedImage: generateMemedImage())
        
        
        let activityViewController = UIActivityViewController(activityItems: [(meme?.memedImage)! as UIImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
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
}


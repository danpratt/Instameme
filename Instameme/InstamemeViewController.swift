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
    
    // Image View
    @IBOutlet weak var memeImageView: UIImageView!
    
    // Camera button
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // Delegates
    let textFieldDelegate = MemeTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Disable the camera button if user doesn't have one
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Setup Memes
        topTextField.defaultTextAttributes = textFieldDelegate.textAttributes
        bottomTextField.defaultTextAttributes = textFieldDelegate.textAttributes
        topTextField.textAlignment = .center
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = .center
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
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


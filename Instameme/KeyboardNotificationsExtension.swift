//
//  KeyboardNotificationsExtension.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/7/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import UIKit

    var isViewMovedUp = false

// Using extension to prevent ViewController from getting too messy
extension InstamemeViewController {
    
    // Turn on notifications when the keyboard view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    // Turn off notifications when keyboard will disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // Called when the keyboard is about to show up, moves view up so it isn't covered up by the keyboard
    func keyboardWillShow(_ notification: Notification) {
        print(notification)
        if !isViewMovedUp && bottomTextField.isFirstResponder {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            isViewMovedUp = true
        }
    }
    
    // Moves view back down when keyboard will go away
    func keyboardWillHide(_ notifcation: Notification) {
        if isViewMovedUp && bottomTextField.isFirstResponder {
            self.view.frame.origin.y += getKeyboardHeight(notifcation)
            isViewMovedUp = false
        }
    }
    
    // Gets keyboard height so we know how far to move the view
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // Let's us know which notifications to keep an eye out for
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // Stop keeping an eye out for them when we don't need them anymore
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}

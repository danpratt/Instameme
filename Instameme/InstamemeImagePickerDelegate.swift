//
//  InstamemeImagePickerDelegate.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/7/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import Foundation
import UIKit

extension InstamemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
            memeImageView.contentMode = .scaleAspectFit
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

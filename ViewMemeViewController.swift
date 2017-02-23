//
//  ViewMemeViewController.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/21/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit

class ViewMemeViewController: UIViewController {
    
    // MARK: Properties
    var meme: Meme? = nil
    var shouldReturnToRoot = false

    // MARK :IBOutlets
    
    @IBOutlet weak var memeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memeImage.image = meme?.memedImage
        memeImage.contentMode = .scaleAspectFit
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if shouldReturnToRoot {
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        
    }

    @IBAction func editSelectedMemeButtonPushed(_ sender: Any) {
        let editorVC = storyboard?.instantiateViewController(withIdentifier: "MemeCreatorStoryboard") as! InstamemeViewController
        
        editorVC.meme = meme
        editorVC.topText = meme?.topText ?? "TOP"
        editorVC.bottomText = meme?.bottomText ?? "BOTTOM"
        editorVC.memeImage = meme?.originalImage
        editorVC.shouldShareButtonBeVisible = true
        editorVC.canCancel = true

        navigationController?.present(editorVC, animated: true, completion: nil)
        
        shouldReturnToRoot = true
    }
    
}

//
//  InstamemeTableViewController.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/17/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit

class InstamemeTableViewController: UITableViewController {
    
    // MARK: Properties
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load up memes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        print (memes.count)
        
        if memes.count == 0 {
            let instamemeVC = storyboard!.instantiateViewController(withIdentifier: "MemeCreatorStoryboard") as! InstamemeViewController
            navigationController!.present(instamemeVC, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }

 }

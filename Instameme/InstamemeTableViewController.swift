//
//  InstamemeTableViewController.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/17/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit

class InstamemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var memes: [Meme]!
    let reuseID = "tableOfMemes"

    // MARK: IBOutlets
    @IBOutlet var memesTableView: UITableView!
    
    // Does work when view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load up memes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        print("table count \(memes.count)")

        memesTableView.reloadData()
        
        if memes.count == 0 {
            let instamemeVC = storyboard!.instantiateViewController(withIdentifier: "MemeCreatorStoryboard") as! InstamemeViewController
            navigationController!.present(instamemeVC, animated: true, completion: nil)
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memes.count)
        return memes.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID)
        let currentMeme = memes[(indexPath as NSIndexPath).row]
    
        // Setup cell using meme data
        cell?.textLabel?.text = currentMeme.topText
        cell?.detailTextLabel?.text = currentMeme.bottomText
        cell?.imageView?.image = currentMeme.memedImage
        cell?.imageView?.contentMode = .scaleAspectFit
        
        return cell!
    }

 }

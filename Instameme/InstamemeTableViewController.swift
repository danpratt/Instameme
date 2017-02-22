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
    
    // Does work when view will load
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        if memes.count == 0 {
            let instamemeVC = storyboard!.instantiateViewController(withIdentifier: "MemeCreatorStoryboard") as! InstamemeViewController
            navigationController!.present(instamemeVC, animated: true, completion: nil)
        }
    }

    //  Refresh table when we get back to it from editing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        memesTableView!.reloadData()
        // Make sure the tab bar shows up
        tabBarController?.tabBar.isHidden = false
    }
    
    // Bases number of rows on the number of memes
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    // Draws cell with image, and text from meme
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID)
        let currentMeme = memes[(indexPath as NSIndexPath).row]
    
        // Setup cell using meme data
        cell?.textLabel?.text = "\(currentMeme.topText)...\(currentMeme.bottomText)"
        cell?.imageView?.image = currentMeme.memedImage
        cell?.imageView?.contentMode = .scaleAspectFit
        
        return cell!
    }
    
    // Allow user to view the meme
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeViewerVC = storyboard?.instantiateViewController(withIdentifier: "MemeViewer") as! ViewMemeViewController
        let meme = memes[indexPath.row]
 
        memeViewerVC.meme = meme
        
        navigationController?.pushViewController(memeViewerVC, animated: true)
    }
    
    // MARK: Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEdit" {
            let memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeCreatorStoryboard") as! InstamemeViewController
            memeEditorVC.canCancel = true
            present(memeEditorVC, animated: true, completion: nil)
        }
    }

 }
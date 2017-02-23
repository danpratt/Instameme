//
//  InstamemeCollectionViewController.swift
//  Instameme
//
//  Created by Daniel Pratt on 2/17/17.
//  Copyright © 2017 Daniel Pratt. All rights reserved.
//

import UIKit

class InstamemeCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    var memes: [Meme]!
    
    // MARK: IBOutlets
    
    @IBOutlet var memeCollectionView: UICollectionView!
    @IBOutlet weak var instamemeFlowLayout: UICollectionViewFlowLayout!
    
    // Initial setup
    override func viewDidLoad() {
        // Load up memes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        // Setup flow layout
        setupFlowLayout()
    }

    //  Refresh collection when we get back to it from editing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        memeCollectionView!.reloadData()
        // Make sure bottom tab is visible
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Functions
    
    func setupFlowLayout() {
        let space:CGFloat = 8.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        instamemeFlowLayout.minimumInteritemSpacing = space
        instamemeFlowLayout.minimumLineSpacing = space
        instamemeFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    // MARK: Required Functions for Collection Views
    
    // Number of Memes to show
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    // Draws cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create cell and current meme object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemesCollectionIdentifier", for: indexPath) as! InstamemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        // Update cell properties
        cell.memeImage.image = meme.memedImage
        cell.memeImage.contentMode = .scaleAspectFit
        
        return cell
    }
    
    // Called when a collection view is tapped
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

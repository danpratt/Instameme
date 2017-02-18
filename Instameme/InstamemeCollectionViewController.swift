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
    
    @IBOutlet weak var instamemeFlowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load up memes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        // Setup flow layout
        setupFlowLayout()
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
        
        return cell
    }
    
    

}

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
        didRotate(self)
        
        // Check for rotation
        NotificationCenter.default.addObserver(self, selector: #selector(didRotate(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    //  Refresh collection when we get back to it from editing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        memeCollectionView!.reloadData()
        // Make sure bottom tab is visible
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Layout Functions
    
    // Does setup
    func setupFlowLayout(_ size: CGSize) {
//        let space: CGFloat = 1.0
//        var memesInRow: CGFloat = 3
//        // check which way device is rotated
//        if size.width > size.height {
//            memesInRow = 5
//        }
        
//        let dimension = size.width / memesInRow
        
//        instamemeFlowLayout.minimumInteritemSpacing = space
//        instamemeFlowLayout.minimumLineSpacing = space
        
//        instamemeFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    // Get new screen size and update flowLayout when the screen rotates
    func didRotate(_: Any) {
        setupFlowLayout(view.frame.size)
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
        cell.memeImage.image = meme.originalImage
        
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

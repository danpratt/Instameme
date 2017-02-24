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
        // set space used in calculation from flowLayout settings set in Storyboard.  If you want to adjust the space, do it in storyboard, not here
        let space: CGFloat = instamemeFlowLayout.sectionInset.left

        // set number of items in a row.  3 for portrait, 5 for landscape
        var memesInRow: CGFloat {
            if size.height > size.width {
                return 3
            } else {
                return 5
            }
        }
        
        // calculate item dimensions based on screen width
        // Create constant for width, to make calculation easier to read
        let width = size.width
        // Remove the spaces between items from the available screen real estate to the items
        let widthAvailableToItems = width - ((memesInRow + 1) * space)
        // Using the available real estate, split it up depending on how many items we want to display based on orientation
        let itemSize = widthAvailableToItems / memesInRow
        
        // Now just setup the item as a square with the size we figured out
        // Using squares because they are much more visually appealing
        instamemeFlowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
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
        cell.memeImage.image = meme.originalImage  // Set the original image, since we will be drawing over it
        
        // set labels to correct fonts
//        cell.memeTopText.font = meme.settings.displayFont
//        cell.memeBottomText.font = meme.settings.displayFont
        setFontFor(label: cell.memeTopText, settings: meme.settings)
        setFontFor(label: cell.memeBottomText, settings: meme.settings)
        
        // set labvel text values
        cell.memeTopText.text = meme.topText
        cell.memeBottomText.text = meme.bottomText
        
        return cell
    }
    
    // Setup font (could remove this feature, because view displays almost always look better with white font color)
    func setFontFor(label: UILabel , settings: Settings) {
        label.font = settings.displayFont
        switch settings.fontShouldBeBlack {
        case true:
            label.textColor = .black
        case false:
            label.textColor = .white
        }
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

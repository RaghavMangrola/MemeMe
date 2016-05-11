//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/10/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
  
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFlowLayout()
  }
  
  override func viewWillAppear(animated: Bool) {
    self.collectionView?.reloadData()
  }

  func setupFlowLayout() {
    flowLayout.minimumInteritemSpacing = 1
    flowLayout.minimumLineSpacing = 1
    flowLayout.itemSize = CGSizeMake((view.frame.size.width / 3) - 1, view.frame.size.width / 3)
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    coordinator.animateAlongsideTransition(nil) { _ in self.setupFlowLayout()}
  }
  
  // MARK: CollectionView Delegate Methods
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let detailVC = storyboard?.instantiateViewControllerWithIdentifier("memeDetailViewController") as! MemeDetailViewController
    detailVC.meme = memes[indexPath.row].memedImage
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  // MARK: CollectionView Data Source Methods
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewMemeCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
    
    cell.memeImageView.contentMode = .ScaleAspectFill
    cell.memeImageView.image = memes[indexPath.row].memedImage
    return cell
  }
}

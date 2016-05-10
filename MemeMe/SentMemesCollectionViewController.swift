//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/10/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
  
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
  
  override func viewDidAppear(animated: Bool) {
    self.collectionView!.reloadData()
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewMemeCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
    cell.memeImageView.contentMode = .ScaleAspectFit
    cell.memeImageView.image = memes[indexPath.row].memedImage
    return cell
  }
}

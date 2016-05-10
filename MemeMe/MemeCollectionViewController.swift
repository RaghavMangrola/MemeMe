//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/10/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
  
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }

}

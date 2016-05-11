//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/10/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
  
  var meme: UIImage?
  
  @IBOutlet weak var memeImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    memeImage.contentMode = .ScaleAspectFit
    memeImage.image = meme
  }
}

//
//  ViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/5/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  let imagePickerVC = UIImagePickerController()
  
  @IBOutlet weak var memeImageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  
  @IBAction func cameraButtonPressed(sender: AnyObject) {
    presentImagePickerVC(sourceType: .Camera)
  }
  
  @IBAction func albumButtonPressed(sender: AnyObject) {
    presentImagePickerVC(sourceType: .PhotoLibrary)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    imagePickerVC.delegate = self
    memeImageView.contentMode = .ScaleAspectFit
    cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
  }
  
  func presentImagePickerVC(sourceType sourceType: UIImagePickerControllerSourceType) {
    imagePickerVC.sourceType = sourceType
    presentViewController(imagePickerVC, animated: true, completion: nil)
  }
  
  // UIImagePickerControllerDelegate Functions
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      memeImageView.image = image
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
}


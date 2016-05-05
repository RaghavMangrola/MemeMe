//
//  ViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/5/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  let imagePickerVC = UIImagePickerController()
  let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.blackColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
  ]
  
  @IBOutlet weak var memeImageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet var textFields: [UITextField]!
  
  
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
    setupTextFields()
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.unsubscribeFromKeyboardNotifications()
  }
  
  func presentImagePickerVC(sourceType sourceType: UIImagePickerControllerSourceType) {
    imagePickerVC.sourceType = sourceType
    presentViewController(imagePickerVC, animated: true, completion: nil)
  }
  
  func setupTextFields() {
    for textField in textFields {
      textField.delegate = self
      textField.defaultTextAttributes = memeTextAttributes
      textField.textAlignment = .Center
    }
  }
  
  // MARK: Keyboard
  
  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWillShow(notification: NSNotification) {
    self.view.frame.origin.y -= getKeyboardHeight(notification)
  }
  
  func keyboardWillHide(notifcation: NSNotification) {
    self.view.frame.origin.y += getKeyboardHeight(notifcation)
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo!
    let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.CGRectValue().height
  }
  
 
  
  // MARK: UIImagePickerControllerDelegate Functions
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      memeImageView.image = image
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: UITextField Delegate Functions
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}


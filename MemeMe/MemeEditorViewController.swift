//
//  ViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/5/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  let imagePickerVC = UIImagePickerController()
  let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.blackColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
  ]
  var meme: Meme?
  
  @IBOutlet weak var memeImageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet var textFields: [UITextField]!
  @IBOutlet weak var topToolbar: UIToolbar!
  @IBOutlet weak var bottomToolbar: UIToolbar!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  
  
  @IBAction func cameraButtonPressed(sender: AnyObject) {
    presentImagePickerVC(sourceType: .Camera)
  }
  
  @IBAction func albumButtonPressed(sender: AnyObject) {
    presentImagePickerVC(sourceType: .PhotoLibrary)
  }
  
  @IBAction func shareButtonPressed(sender: AnyObject) {
    let image = generateMembedImage()
    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    presentViewController(activityVC, animated: true, completion: nil)
    
    activityVC.completionWithItemsHandler = {(activityType: String?, completed: Bool, returnedItems: [AnyObject]?, activityError: NSError?) in
      if completed {
        self.save()
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
  }
  
  @IBAction func cancelButtonPressed(sender: AnyObject) {
    topTextField.text = "Top"
    bottomTextField.text = "Bottom"
    memeImageView.image = nil
    shareButton.enabled = false
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    imagePickerVC.delegate = self
    memeImageView.contentMode = .ScaleAspectFit
    cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
    shareButton.enabled = false
    setupTextFields()
//    prefersStatusBarHidden()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
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
  
  func save() {
    meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: memeImageView.image!, memedImage: generateMembedImage())
    
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    appDelegate.memes.append(meme!)
  }
  
  func generateMembedImage() -> UIImage {
    
    // Hide Toolbar
    topToolbar.hidden = true
    bottomToolbar.hidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawViewHierarchyInRect(self.view.frame,
                                 afterScreenUpdates: true)
    let memedImage : UIImage =
      UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    // Show toolbar
    
    topToolbar.hidden = false
    bottomToolbar.hidden = false
    
    return memedImage
  }
  
//  override func prefersStatusBarHidden() -> Bool {
//    return true
//  }
  
  
  // MARK: Keyboard
  
  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWillShow(notification: NSNotification) {
    if bottomTextField.isFirstResponder() {
      self.view.frame.origin.y = getKeyboardHeight(notification) * -1
    }
  
  }
  
  func keyboardWillHide(notifcation: NSNotification) {
    if bottomTextField.isFirstResponder() {
      self.view.frame.origin.y = 0
    }
  
    
  
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
      shareButton.enabled = true
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
  
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField.text == "TOP" || textField.text == "BOTTOM" {
      textField.text = ""
    }
    
  }
  
}


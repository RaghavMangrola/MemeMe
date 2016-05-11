//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/10/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
  
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
    
  override func viewDidAppear(animated: Bool) {
    tableView.reloadData()
  }
  
  // MARK: UITableView Delegate Methods
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return view.frame.size.height / 5
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detailVC = storyboard?.instantiateViewControllerWithIdentifier("memeDetailViewController") as! MemeDetailViewController
    detailVC.meme = memes[indexPath.row].memedImage
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  // MARK: UITableView Data Source Methods
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tableViewMemeCell", forIndexPath: indexPath)
    cell.imageView?.contentMode = .ScaleAspectFit
    cell.imageView?.image = memes[indexPath.row].memedImage
    cell.textLabel?.text = "\(memes[indexPath.row].topText) \(memes[indexPath.row].bottomText)"
    return cell
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }
}

//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Raghav Mangrola on 5/10/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
  
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func viewDidAppear(animated: Bool) {
    self.tableView.reloadData()
  }
  
  
  
  // MARK: UITableView Delegate Methods
  
  // MARK: UITableView Data Source Methods
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tableViewMemeCell", forIndexPath: indexPath)
    cell.textLabel?.text = "Hello"
    cell.imageView?.image = memes[indexPath.row].image
    return cell
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }
}

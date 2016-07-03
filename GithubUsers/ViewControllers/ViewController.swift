//
//  ViewController.swift
//  GithubUsers
//
//  Created by Gleb on 1/21/16.
//  Copyright © 2016 LT. All rights reserved.
//

import UIKit
import BNRCoreDataStack

class ViewController: UIViewController, UITableViewDelegate, UsersCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coreDataStack: CoreDataStack!
    var dataSource: UsersDataSource?
    var selectedAvatarURLString: String?
    var loader: UsersLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            coreDataStack = try CoreDataStack.constructInMemoryStack(withModelName: "GithubUsers");
        } catch {
            print(error)
            return
        }
        
        loader = UsersLoader(context: coreDataStack!.newBackgroundWorkerMOC());
        loader!.load(100, since: 1);
        dataSource = UsersDataSource(tableView: tableView, context: coreDataStack.mainQueueContext)
        dataSource?.cellsDelegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonDidClicked(sender: AnyObject) {
        loader!.loadNext();
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetails" {
            if let userDetailsViewController = segue.destinationViewController as? UserDetailViewController {
                userDetailsViewController.avatarUrlString = self.selectedAvatarURLString
            }
        }
    }
    
    // MARK: - UsersCellDelegate
    
    func avatarDidSelected(avatarUrlString: String?) {
        selectedAvatarURLString = avatarUrlString
        performSegueWithIdentifier("ShowDetails", sender: self);
    }

}


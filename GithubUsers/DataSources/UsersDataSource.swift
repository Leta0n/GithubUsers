//
//  UsersDataSource.swift
//  GithubUsers
//
//  Created by Gleb on 1/24/16.
//  Copyright © 2016 LT. All rights reserved.
//

import UIKit
import CoreData


class UsersDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    weak var tableView: UITableView?
    var FRC: NSFetchedResultsController!
    let userCellIdentifier: String = "UserTableViewCell"
    weak var cellsDelegate: UsersCellDelegate?
    
    // MARK: -
    
    init(tableView: UITableView, context: NSManagedObjectContext) {
        self.tableView = tableView
        super.init()
        self.FRC = usersFRCWithContext(context)
        self.tableView?.dataSource = self
        self.FRC.delegate = self
        fetch()
    }
    
    // MARK: - Private
    
    private func fetch() {
        do {
            try FRC.performFetch()
        } catch {
            print("Something went wrong. Please try again later")
        }
    }
    
    private func usersFRCWithContext(context: NSManagedObjectContext) -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: User.objectMapping().primaryKey, ascending: true)]
         return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var result = 0
        if let sections = FRC.sections {
            result = sections.count
        }
        return result
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        if let sections = FRC.sections {
            result = sections[section].numberOfObjects
        }
        return result
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(userCellIdentifier) as! UserTableViewCell
        let user = FRC.objectAtIndexPath(indexPath) as! User
        
        cell.updateWithUser(user)
        cell.delegate = self.cellsDelegate
        
        return cell
    }
    
    //MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView?.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        if let _ = self.tableView {
            let rowAnimation = UITableViewRowAnimation.Automatic
            
            switch type {
            case .Delete : self.tableView!.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: rowAnimation)
            case .Insert : self.tableView!.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: rowAnimation)
            case .Move :
                self.tableView!.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: rowAnimation)
                self.tableView!.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: rowAnimation)
            case .Update : self.tableView!.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: rowAnimation)
            }
            
        }
    }
}

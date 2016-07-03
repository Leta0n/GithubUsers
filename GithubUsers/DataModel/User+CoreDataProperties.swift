//
//  User+CoreDataProperties.swift
//  GithubUsers
//
//  Created by Gleb on 1/21/16.
//  Copyright © 2016 LT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var uuid: NSNumber?
    @NSManaged var avatarURLString: String?
    @NSManaged var profileURLString: String?
    @NSManaged var login: String?
}

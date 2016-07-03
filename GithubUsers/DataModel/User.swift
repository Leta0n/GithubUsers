//
//  User.swift
//  GithubUsers
//
//  Created by Gleb on 1/21/16.
//  Copyright © 2016 LT. All rights reserved.
//

import Foundation
import CoreData
import EasyMapping

class User: EKManagedObjectModel {
    
    override class func objectMapping() -> EKManagedObjectMapping {
        return EKManagedObjectMapping (forEntityName: "User") { (mapping) -> Void in
            mapping.mapKeyPath("login", toProperty: "login")
            mapping.mapKeyPath("avatar_url", toProperty: "avatarURLString")
            mapping.mapKeyPath("html_url", toProperty: "profileURLString")
            mapping.mapKeyPath("id", toProperty: "uuid")
            mapping.primaryKey = "uuid"
        }
        
    }
}

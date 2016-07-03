//
//  UsersLoader.swift
//  GithubUsers
//
//  Created by Gleb on 1/23/16.
//  Copyright © 2016 LT. All rights reserved.
//

import UIKit
import CoreData
import EasyMapping

struct UsersLoaderConstants{
    static let UsersURLString = "https://api.github.com/users"
}

class UsersLoader: NSObject {
    
    let context: NSManagedObjectContext
    var nextPageURLString: String? = nil
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Public

    func load(perPage: Int, since: Int) {
        performUserLoading(UsersLoaderConstants.UsersURLString, params: ["since" : String(since), "per_page" : String(perPage)])
    }
    
    func loadNext() {
        guard nextPageURLString != nil else {
            return
        }
        
        performUserLoading(nextPageURLString!, params: nil)
    }
    
    // MARK: - Private
    
    func performUserLoading(urlStrung: String, params:[String : String]?) {
        let request = GetGithubUsersRequest(session: NSURLSession.sharedSession(), urlSting: urlStrung, parametrs: params)
        
        request.start() { rawUsers, nextPageURLString, error in
            self.nextPageURLString = nextPageURLString
            guard (rawUsers != nil) || (error == nil) else {
                print(error)
                return
            }
            self.updateUsers(rawUsers!)
        }
    }
    
    private func updateUsers(rawUsers: Array<Dictionary<String, AnyObject>>)
    {
        context.performBlock {
            EKManagedObjectMapper.arrayOfObjectsFromExternalRepresentation(rawUsers, withMapping: User.objectMapping(), inManagedObjectContext: self.context)
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }

}

//
//  GetUsersRequest.swift
//  GithubUsers
//
//  Created by Gleb on 1/21/16.
//  Copyright © 2016 LT. All rights reserved.
//

import UIKit
import Foundation

typealias GetUsersCompletionHandler = (rawUsers: Array<Dictionary<String, AnyObject>>?, nextPageURLString: String?, error: NSError?) -> ()

class GetGithubUsersRequest: NetworkRequest {
    
    func start(completion: GetUsersCompletionHandler?) {
        perform() { data, response, error in
            do {
                guard (data != nil) else {
                    print(error?.localizedDescription)
                    return
                }
                if let responsedObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                    if let rawUsers = responsedObject as? Array<Dictionary<String, AnyObject>> {
                        completion?(rawUsers: rawUsers, nextPageURLString: self.getNextPageURLFromResponse(response!), error: error)
                    }
                }
            } catch let parsingError as NSError {
                print(parsingError.localizedDescription)
            }
        }
    }
    
    // MARK: Private
    
    private func getNextPageURLFromResponse(response: NSURLResponse) -> String? {
        var result: String?
        if let httpResponse = response as? NSHTTPURLResponse {
            if let headerNavigationString = httpResponse.allHeaderFields["Link"] as? String {
                result = getNextPageURLFromHeaderString(headerNavigationString);
            }
        }
        
        return result!
    }
    
    private func getNextPageURLFromHeaderString(string: String) -> String? {
        let elements = string.componentsSeparatedByString(";")
        var nextURLString: String?
        
        if let firstElement: String = elements[0] {
            nextURLString = firstElement[firstElement.startIndex.advancedBy(1)...firstElement.endIndex.advancedBy(-2)]
        }
        
        return nextURLString!
    }
}

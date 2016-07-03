//
//  NetworkRequest.swift
//  GithubUsers
//
//  Created by Gleb on 1/23/16.
//  Copyright © 2016 LT. All rights reserved.
//

import UIKit

typealias RequestCompletionHandler = (data: NSData?, response: NSURLResponse?, error: NSError?) -> ()

    class NetworkRequest: NSObject {
    
    let urlSession: NSURLSession
    var requestURL: NSURL?
    var dataTask: NSURLSessionDataTask?
    
    // MARK: -
    
    init(session: NSURLSession, urlSting:  String, parametrs: [String : String]?) {
        self.urlSession = session
        super.init()
        var requestURLSting = urlSting

        if parametrs?.count > 0 {
            requestURLSting.appendContentsOf("?")
            for param in parametrs! {
                requestURLSting.appendContentsOf(String(format: "%@=%@&", arguments: [param.0, param.1]))
            }
        }
        
        requestURL = NSURL.init(string: requestURLSting)
    }

    // MARK: Public
    
    func perform(completion: RequestCompletionHandler?) {
        guard (requestURL != nil) else {
            return
        }
        dataTask = urlSession.dataTaskWithURL(requestURL!, completionHandler: {(data, response, error) in
            completion?(data: data, response: response, error: error)
           
        })
        dataTask?.resume()
    }
    
    func cancel() {
        dataTask?.cancel()
    }
}

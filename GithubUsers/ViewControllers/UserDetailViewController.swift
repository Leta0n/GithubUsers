//
//  UserDetailViewController.swift
//  GithubUsers
//
//  Created by Gleb on 1/24/16.
//  Copyright © 2016 LT. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	var avatarUrlString: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if (avatarUrlString != nil) {
			if let imageURL = NSURL(string: avatarUrlString!) {
				imageView.af_setImageWithURL(imageURL)
			}
		}
	}
	
	@IBAction func backButtonDidClicked(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
}

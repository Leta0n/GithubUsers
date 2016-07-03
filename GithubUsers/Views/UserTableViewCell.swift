//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Gleb on 1/23/16.
//  Copyright © 2016 LT. All rights reserved.
//

import UIKit
import AlamofireImage

protocol UsersCellDelegate: class {
	func avatarDidSelected(avatarUrlString: String?)
}

class UserTableViewCell: UITableViewCell {
	
	@IBOutlet weak var avatarButton: UIButton!
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var profileLinkLabel: UILabel!
	
	weak var delegate: UsersCellDelegate?
	var avatarURLString: String?
	
	override func prepareForReuse() {
		super.prepareForReuse()
		avatarImageView.af_cancelImageRequest()
		avatarImageView.image = nil
	}
	
	// MARK:-
	
	func updateWithUser(user: User) {
		loginLabel.text = user.login
		profileLinkLabel.text = user.profileURLString
		
		
		if let avatarURLString = user.avatarURLString, imageURL = NSURL(string: avatarURLString) {
			self.avatarURLString = avatarURLString
			avatarImageView.af_setImageWithURL(imageURL)
		}
	}
	
	@IBAction func avatarButtonDidClicked(sender: AnyObject) {
		self.delegate?.avatarDidSelected(self.avatarURLString)
	}
	
}

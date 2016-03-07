//
//  TweetCell.swift
//  Twitter
//
//  Created by Saul Soto on 2/14/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRetweets: UILabel!
    @IBOutlet weak var userFav: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            userDescription.text = tweet.text
            userName.text = tweet.user?.name
            userAdd.text = "@\(tweet.user!.screenname)"
            userImage?.setImageWithURL(tweet.user!.profileImageUrl!)
            userRetweets?.text = "\(tweet.retweets as Int)"
            userFav?.text = "\(tweet.favorites as Int)"
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
        
        userName.preferredMaxLayoutWidth = userName.frame.size.width
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        userName.preferredMaxLayoutWidth = userName.frame.size.width
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

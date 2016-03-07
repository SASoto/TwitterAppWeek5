//
//  TweetOtherProfiles.swift
//  Twitter
//
//  Created by Saul Soto on 3/6/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit

class TweetOtherProfiles: UIViewController {

    
    @IBOutlet weak var otherImage: UIImageView!
    @IBOutlet weak var otherTweets: UILabel!
    @IBOutlet weak var otherFollowers: UILabel!
    @IBOutlet weak var otherFollowing: UILabel!
    @IBOutlet weak var otherAddName: UILabel!
    
    var tweets: [Tweet]?
    
    var tweet: Tweet! {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        otherImage.layer.cornerRadius = 3
        otherImage.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView()
    {
        otherAddName?.text = "@\(tweet?.user?.screenname)"
        //otherImage?.setImageWithURL(tweet.user!.profileImageUrl!)
        //otherFollowers?.text = "\((tweet?.user?.tweetFollowersNum)!)"
        //otherFollowing?.text = "\((tweet?.user?.tweetFollowingNum)!)"
        //otherTweets?.text = "\((tweet?.user?.tweetNum)!)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

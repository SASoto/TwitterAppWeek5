//
//  TweetProfile.swift
//  Twitter
//
//  Created by Saul Soto on 3/6/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit

class TweetProfile: UIViewController {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addName: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    
    var tweets: [Tweet]?
    
    var tweet: Tweet! {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView()
    {
        profileImage?.setImageWithURL(User.currentUser!.profileImageUrl!)
        addName?.text = "@\(User.currentUser!.screenname)"
        numTweets?.text = "\((User.currentUser?.tweetNum)!)"
        numFollowing?.text = "\((User.currentUser?.tweetFollowingNum)!)"
         numFollowers?.text = "\((User.currentUser?.tweetFollowersNum)!)"
    }

    @IBAction func onLogOut(sender: AnyObject) {
        
        User.currentUser?.logout()
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

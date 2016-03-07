//
//  TweetDetails.swift
//  Twitter
//
//  Created by Saul Soto on 2/20/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit

class TweetDetails: UIViewController {
    
    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDescrip: UILabel!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var userTime: UILabel!
    @IBOutlet weak var userRetweet: UILabel!
    @IBOutlet weak var userFavor: UILabel!
    
    var tweets: [Tweet]?
    
    var tweet: Tweet! {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateView()
        profImage.layer.cornerRadius = 3
        profImage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView()
    {
        userDescrip?.text = tweet.text
        userName?.text = tweet.user?.name
        userAdd?.text = "@\(tweet.user!.screenname)"
        profImage?.setImageWithURL(tweet.user!.profileImageUrl!)
        userTime?.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
        
        //Credit for these declerations goes to Monte Thakkar, slack @monte9
        userRetweet?.text = "\(tweet.retweets as Int)"
        
        userFavor?.text = "\(tweet.favorites as Int)"
        
    }
    
    //Credit to David Wayman and Monte Thakkar for this method, slack @dwayman and @monte9
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        // Figure out time ago
        if (rawTime <= 60) { // SECONDS
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) { // MINUTES
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) { // HOURS
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) { // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "OtherProf" {
            
            
    
            
        }

    }*/
    

}

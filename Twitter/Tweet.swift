//
//  Tweet.swift
//  Twitter
//
//  Created by Saul Soto on 2/13/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    //Credit for these declerations goes to Monte Thakkar, slack @monte9
    var favorites: Int!
    var retweets: Int!
   
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        //Credit for these declerations goes to Monte Thakkar, slack @monte9
        favorites = dictionary["favorite_count"] as? Int
        retweets = dictionary["retweet_count"] as? Int
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array{
        
            tweets.append(Tweet(dictionary: dictionary))
            
        }
        return tweets
    }
}

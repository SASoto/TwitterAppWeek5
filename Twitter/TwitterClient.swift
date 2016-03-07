//
//  TwitterClient.swift
//  Twitter
//
//  Created by Saul Soto on 2/13/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


let twitterConsumerKey = "8mjTxxgLvXynFPZDtR9DnB99H"
let twitterConsumerSecret = "4I6I2y1mtASY6dIIMiBnSDY55S5c7Y9xdtz0l3AaQISeCMfw9u"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithCompletion(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("home timeline: \(response!)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
           
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) {(error: NSError!) -> Void in
                print("Failed to get requestion token")
                self.loginCompletion?(user: nil, error: error)
        }
    
    }
    
    //Credit to Michael Gonzalez, slack @mgkael for following method
    func compose(tweet: String, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/update.json?status=\(tweet)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("just tweeted \(tweet)!")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )
    }
    
    func openURL(url: NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET(
                "1.1/account/verify_credentials.json",
                parameters: nil,
                success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                    //print("user: \(response!)")
                    var user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                    print("user: \(user.name)")
                    self.loginCompletion?(user: user, error:nil)
                },
                failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
        }) {(error: NSError!) -> Void in
            print("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }

    }

}

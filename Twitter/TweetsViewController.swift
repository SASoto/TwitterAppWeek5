//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Saul Soto on 2/13/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadList(notification: NSNotification){
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
        })
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: {(tweets, error) -> () in
                    self.tweets = tweets
                })

                self.tableView.reloadData()
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        
        User.currentUser?.logout()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "TDetails" /*|| segue.identifier == "OthProfiles"*/ {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let twittertweet = tweets![indexPath!.row]
            
            let tweetDetails = segue.destinationViewController as! TweetDetails
            tweetDetails.tweet = twittertweet
            
        }
        
        /*if segue.identifier == "OtherProf" {
            
            let image = sender as! UIButton
            let view = image.superView!
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let twittertweet = tweets![indexPath!.row]
            
            let tweetDetails = segue.destinationViewController as! TweetOtherProfiles
            
            tweetDetails.tweet = twittertweet
        }*/
        
        print("prepare for segue")
        
        
        }

}

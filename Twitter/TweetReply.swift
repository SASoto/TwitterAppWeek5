//
//  TweetReply.swift
//  Twitter
//
//  Created by Saul Soto on 2/22/16.
//  Copyright © 2016 CodePath - Saul Soto. All rights reserved.
//

import UIKit

class TweetReply: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var textField: UITextView!
    
    var tweets: Tweet!
    var user: User?
    var writtenTweet: String = ""
    let twitterClient = TwitterClient.sharedInstance
    
    var tweet: Tweet! {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        
        updateView()
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView()
    {
        userName?.text = User.currentUser?.name
        userAdd?.text = "@\(User.currentUser!.screenname)"
        userImage?.setImageWithURL(User.currentUser!.profileImageUrl!)
    }
    
    //Credit to Michael Gonzalez for the textViewDidChange and onSend methods, slack @mgkael for the following code block
    
    func textViewDidChange(textView: UITextView) {
        writtenTweet = textField.text
        
    }
    
  
    @IBAction func onSend(sender: AnyObject)  {
        
        let tweet = writtenTweet.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        twitterClient.compose(tweet!, params: nil, completion: { (error) -> () in
        print("about to tweet")
            self.writtenTweet = self.textField.text
            
        })
        
        let seconds = 3.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            
            self.navigationController?.popViewControllerAnimated(true)
            
        })
        //navigationController?.popViewControllerAnimated(true)
        //dismissViewControllerAnimated(true, completion: {})
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
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

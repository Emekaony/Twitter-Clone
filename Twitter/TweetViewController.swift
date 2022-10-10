//
//  TweetViewController.swift
//  Twitter
//
//  Created by SHAdON . on 10/8/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    let postUrl = "https://api.twitter.com/1.1/statuses/update.json"
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.becomeFirstResponder()
        
        // UI Changes
        tweetTextView.layer.borderWidth = CGFloat(2)
        tweetTextView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 250, alpha: 1)
        tweetTextView.layer.cornerRadius = 20
        tweetTextView.contentInset = UIEdgeInsets(top: 5, left: 4, bottom: 5, right: 5)
    }
    
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        // we do not want anything to happen when we dismiss
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweet(_ sender: UIBarButtonItem) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true)
            }, failure: { Error in
                print("Error posting the tweet", Error)
                self.dismiss(animated: true)
            })
        } else {
            self.dismiss(animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

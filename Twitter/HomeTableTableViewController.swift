//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by SHAdON . on 10/2/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    // this is hwo you add refresh control to your table view!
    let myRefreshControl = UIRefreshControl()
    
    let imageUrlEndpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        // now tell the table view which refresh control it is gonna use
        tableView.refreshControl = myRefreshControl
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadTweets()
    }
    
    // necessary for target-action pair
    @objc func loadTweets() {
        
        numberOfTweets = 20
        
        let myUrl = imageUrlEndpoint
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            // clean up the array
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            // stop the refreshing here
            self.myRefreshControl.endRefreshing()
            
        }, failure: { Error in
            print("Could not retrieve tweet oh  no!")
        })
        
    }
    
    func loadMoreTweets() {
        
        let myUrl = imageUrlEndpoint
        
        numberOfTweets += numberOfTweets + 20
        let myParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            // clean up the array
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
        }, failure: { Error in
            print("Could not retrieve tweet oh  no!")
        })
        
    }
    
    
    @IBAction func onLogOut(_ sender: UIBarButtonItem) {
        TwitterAPICaller.client?.logout()
        // send us back to the home screen after we log out
        self.dismiss(animated: true)
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    // when we get to the end of the tweets, load more!
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweet", for: indexPath) as! TweetCell
        
        let user = self.tweetArray[indexPath.row]["user"] as! NSDictionary
        
        let imageUrL = URL(string: (user["profile_image_url_https"] as! String))
        print("Image URL: \(imageUrL)")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: imageUrL!) { data, response, error in
            if error != nil {
                print("Fetching the image was unsuccessiful")
                return
            }
            
            let data = try? Data(contentsOf: (response?.url!)!)
            if let safeImageData = data {
                DispatchQueue.main.async {
                    
                    cell.tweet.text = (self.tweetArray[indexPath.row]["text"] as! String)
                    cell.userName.text = (user["name"] as! String)
                    cell.profilePic.image = UIImage(data: safeImageData)
                    cell.profilePic.contentMode = .scaleAspectFit
                }
            }
        }
        // don't forget this line
        task.resume()
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)

        return cell
    }

}

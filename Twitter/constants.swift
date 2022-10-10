//
//  constants.swift
//  Twitter
//
//  Created by SHAdON . on 10/1/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import Foundation

struct K {
    
    struct ApiTokens {
        let authEndPoint = "https://api.twitter.com/oauth/request_token"
        let apiKey = "AGOyDrfsoPcxCf2a9BwFK0jbo"
        let apiSecret = "KruvxWwl4jeVGnvxh4BCrL4GP5BNRKkP7h6KtwLXGjbwWchswI"
        let accessTooken = "1188222948521308160-DGqZwexlJRV6gmSG63PUWYWTNkRxEF"
        let accessTokenSecret = "QdLlCgzy7nNq4inAgLXljWQWCHoI0En8aQcrcqX2uYySr"
    }
    
    struct Tweet {
        let createTweetUrl = "https://api.twitter.com/1.1/favorites/create.json"
        let destroyTweetUrl = "https://api.twitter.com/1.1/favorites/destroy.json"
    }
    
    struct NavIdentifiers {
        let loginToHome = "LoginToHome"
    }
}

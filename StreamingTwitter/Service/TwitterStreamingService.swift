//
//  TwitterStreamingService.swift
//  StreamingTwitter
//
//  Created by Hawk on 25/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import SwifteriOS

let STComsumerKey = "PZKQADuP0jFQzrmiEMdUqztGB"
let STComsumerSecret = "PiQkF0lGx3D4mT22QAe9U6AceVPSEGmcBPUyAKOXEosO7pOrsx"
let STAccessToken = "779999595460001792-6IvC69Eug87J5boWpHLYQfoyaqGutaj"
let STAccessTokenSecret = "F5JZUnXqqcHDF4X0GXAxWeCGzsPcjIeLu84ZYFG7owlKz"

class TwitterStreamingService: NSObject, ServiceStreamingProtocol {
    var swifter : Swifter?
    var tweets : [Tweet]?
    
    static let maximumLastTweets : Int = 5

    
    let concurrentQueue = DispatchQueue(label: "tweetArrayQueue", attributes: .concurrent)
    
    override init() {
        self.swifter = Swifter(consumerKey: STComsumerKey,
                              consumerSecret: STComsumerSecret,
                              oauthToken: STAccessToken,
                              oauthTokenSecret: STAccessTokenSecret)
        
        self.tweets = [Tweet]()
        super.init()
    }
    
    func progressData( result : JSON ) {
        let tweet = Tweet(text : result["text"].string)
        if let text = tweet.text {
            print("Result: \(text)")
        }
        
        DispatchQueue.main.async {
            self.tweets?.append(tweet)
            
            if let tweets = self.tweets, tweets.count > TwitterStreamingService.maximumLastTweets
            {
                self.tweets?.removeFirst()
            }
            
        }
    }
    
    func startStream( progressHandler: @escaping () -> Void, failure: (_ error: String) -> Void ) {
        _ = swifter?.postTweetFilters(track: ["london"],
            progress: { (result:JSON) in
                self.progressData(result: result)
                progressHandler()
            }, stallWarningHandler: { (code, message, percentFull) in
                print("postTweetFilte rs: stallWarningHandler \(code) \(message)")
            }, failure: { (error) in
                print("postTweetFilters: Failure \(error)")
            }
        );
    }
    
    
    func updateData( completionHandler: @escaping () -> Void ) {
        completionHandler()
    }
    func obtainData() -> AnyObject? {
        
        return self.tweets as? AnyObject
    }
}

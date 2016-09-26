//
//  TwitterStreamingService.swift
//  StreamingTwitter
//
//  Created by Hawk on 25/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import SwifteriOS

class TwitterStreamingService: NSObject, ServiceStreamingProtocol {
    var swifter : Swifter?
    var tweets : [Tweet]?
    
    static let maximumLastTweets : Int = 5
    
    let concurrentQueue = DispatchQueue(label: "tweetArrayQueue", attributes: .concurrent)
    
    override init() {
        
        if let plistTwitter = PListFile(plistFileNameInBundle: "Info")?.plist?["Twitter"],
            let STConsumerKey = plistTwitter["Consumer Key"].string,
            let STConsumerSecret = plistTwitter["Consumer Secret"].string,
            let STAccessToken = plistTwitter["Access Token"].string,
            let STAccessTokenSecret = plistTwitter["Access Token Secret"].string
        {
            self.swifter = Swifter(consumerKey: STConsumerKey,
                                   consumerSecret: STConsumerSecret,
                                   oauthToken: STAccessToken,
                                   oauthTokenSecret: STAccessTokenSecret)
        }
        
        self.tweets = [Tweet]()
        
        super.init()
    }
    
    func progressData( result : JSON ) {
        let tweet = Tweet(text : result["text"].string)
        if let text = tweet.text {
            print("Result: \(text)")
        }
        self.tweets?.append(tweet)

        if let tweets = self.tweets, tweets.count > TwitterStreamingService.maximumLastTweets
        {
            self.tweets?.removeFirst()
        }
    }
    
    func startStream( progressHandler: @escaping () -> Void, failure: (_ error: String) -> Void ) {
        _ = swifter?.postTweetFilters(track: ["london"],
            progress: { (result:JSON) in
                
                DispatchQueue.main.async {
                    self.progressData(result: result)
                }
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

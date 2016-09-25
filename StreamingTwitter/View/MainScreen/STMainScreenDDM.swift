//
//  CGMainScreenDDM.swift
//  BabyBee
//
//  Created by v.vasilenko on 02.09.16.
//  Copyright © 2016 v.vasilenko. All rights reserved.
//

import UIKit

enum STMainScreenTableSections : Int {
    case MainSection = 0
}

let STHeightForTwitterRow : CGFloat = 100.0

@objc protocol STMainScreenDelegate {
    func selectedTweet( tweet : Tweet );
}

@objc protocol STMainScreenDDMProtocol : UITableViewDataSource, UITableViewDelegate {
    init?(delegate: STMainScreenDelegate, dataSource: ServiceStreamingProtocol?)
}

class STMainScreenDDM : NSObject, STMainScreenDDMProtocol {
    let delegate: STMainScreenDelegate
    let dataSource : ServiceStreamingProtocol?
    
    required init?(delegate: STMainScreenDelegate, dataSource : ServiceStreamingProtocol?) {
        self.delegate = delegate
        self.dataSource = dataSource
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return STHeightForTwitterRow;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tweets = dataSource?.obtainData() as? [Tweet], indexPath.row < tweets.count {
            delegate.selectedTweet(tweet: tweets[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = dataSource?.obtainData() as? [Tweet] {
            return tweets.count
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweets = dataSource?.obtainData() as? [Tweet]
        
        if let tweet = tweets?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: STTweetCell.self),
                for: indexPath) as? STTweetCell
            {
                cell.configureForModel(indexPath: indexPath, tweet: tweet)
                
                return cell
            }
        }
        return UITableViewCell()
    }
}

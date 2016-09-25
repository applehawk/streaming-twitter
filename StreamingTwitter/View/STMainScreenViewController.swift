//
//  ViewController.swift
//  StreamingTwitter
//
//  Created by Hawk on 25/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit
import SwifteriOS

class STMainScreenViewController: UIViewController, STMainScreenDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewDDM : STMainScreenDDM?
    var service : TwitterStreamingService?
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    // MARK: - STMainScreenDelegate methods
    func selectedTweet(tweet: Tweet) {
        if let text = tweet.text {
            self.presentAlertMessageVC(title: "Tweet message", message: text, settingsButton: false, buttonTitle: "OK", buttonAction: Selector(""))
        }
    }

    // MARK: - ViewController methods
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = activityIndicator
        activityIndicator.transform = CGAffineTransform(scaleX: 2.0, y: 2.0);
        activityIndicator.startAnimating()
    
        service = TwitterStreamingService()
        tableViewDDM = STMainScreenDDM(delegate: self, dataSource: service)
        
        tableView.delegate = tableViewDDM
        tableView.dataSource = tableViewDDM

        let nibMainScreenCell = UINib(nibName: String(describing: STTweetCell.self),
                                      bundle: nil)
        tableView.register(nibMainScreenCell,
                           forCellReuseIdentifier: String(describing: STTweetCell.self))
        
        service?.startStream(progressHandler: {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                print("Progress ...")
            }
        }, failure: { (error) in
            DispatchQueue.main.async {
                self.presentAlertMessageVC(title: "Failure request to StreamingAPI", message: error, settingsButton: true, buttonTitle: "OK", buttonAction: Selector(""))
            }
        })
        
    }
}


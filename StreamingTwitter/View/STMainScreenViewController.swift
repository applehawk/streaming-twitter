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
    // MARK: Injected by Storyboards
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Injected by Typhoon
    var tableViewDDM : STMainScreenDDM?
    var service : ServiceStreamingProtocol?
    
    // MARK: Custom Views of ViewController
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    // MARK: - STMainScreenDelegate methods
    func selectedTweet(tweet: Tweet) {
        if let text = tweet.text {
            self.presentAlertMessageVC(title: "Tweet message", message: text, settingsButton: false, buttonTitle: "OK", buttonAction: "")
        }
    }

    // MARK: - ViewController methods
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        
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
                self.presentAlertMessageVC(title: "Failure request to StreamingAPI", message: error, settingsButton: false, buttonTitle: "OK", buttonAction: "")
            }
        })
        
    }
}


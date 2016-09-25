//
//  Twitt.swift
//  StreamingTwitter
//
//  Created by Hawk on 25/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation

@objc class Tweet : NSObject {
    let text : String?
    
    init(text: String?) {
        self.text = text
        super.init()
    }
}

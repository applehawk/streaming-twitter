//
//  PListFile.swift
//  StreamingTwitter
//
//  Created by Hawk on 26/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation

class PListFile : NSObject {
    var plist : PList? {
        get {
            return self.plistData
        }
    }
    private let plistData : PList?
    
    init?(plistFileNameInBundle plistFile: String ) {
        if let path = Bundle.main.path(forResource: plistFile, ofType: "plist")
        {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                self.plistData = PList(data)
                super.init()
            } catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
}

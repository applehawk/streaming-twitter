//
//  extViewController.swift
//  StreamingTwitter
//
//  Created by Hawk on 25/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import UIKit

let CGAlertMessageButtonOkName = "OK"
let CGAlertMessageButtonCheckConnectionName = "Settings"

extension UIViewController {
    
    func presentAlertMessageVC( title: String, message: String, settingsButton: Bool = false, buttonTitle: String, buttonAction: Selector) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        let tapGesture = UITapGestureRecognizer(target: self, action: buttonAction)
        alert.view.addGestureRecognizer(tapGesture)
        alert.addAction( UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        if settingsButton == true {
            alert.addAction( UIAlertAction(title: CGAlertMessageButtonCheckConnectionName, style: .default, handler: { (action) in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
            }))
        }
        self.present(alert, animated: true, completion: {
        })
    }
}

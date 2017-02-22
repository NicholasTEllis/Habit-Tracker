//
//  HabitDetailViewController.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/20/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class HabitDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = FBSDKShareLinkContent()
        let button = FBSDKShareButton()
        button.shareContent = content
        button.center = self.view.center
        self.view.addSubview(button)
        
        let dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.mode = .shareSheet
        
        content.contentURL = URL(string: "https://developers.facebook.com")

    }

    
   
}

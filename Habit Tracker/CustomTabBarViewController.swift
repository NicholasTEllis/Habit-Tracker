//
//  CustomTabBarViewController.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    @IBOutlet var addButtonTabView: UIView!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: view.center.x - 35, y: view.frame.height - 70, width: 70, height: 70)
        addButtonTabView.frame = frame
        addButtonTabView.layer.cornerRadius = 0.5 * addButtonTabView.bounds.size.width
        addButtonTabView.clipsToBounds = true
        view.addSubview(addButtonTabView)
        
    }

}

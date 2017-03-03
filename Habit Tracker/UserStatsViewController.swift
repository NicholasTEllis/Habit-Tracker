//
//  UserStatsViewController.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/24/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class UserStatsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBottomBorderColor(color: Keys.shared.iconColor5, height: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

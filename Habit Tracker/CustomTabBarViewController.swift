//
//  CustomTabBarViewController.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    // MARK: - Outlets
    
    enum Tab: Int {
        case list
        case stats
        
        struct Info {
            var title: String
            var image: UIImage
        }
        
    }

    // MARK: - Outlets
    
    
    @IBOutlet weak var tabSelection: UIView!
    
    @IBOutlet var addButtonTabView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var listButton: UIButton!
    
    @IBOutlet weak var statsButton: UIButton!
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        let frame = CGRect(x: 0, y: view.frame.height - 70, width: self.view.frame.width, height: 70)
        addButtonTabView.frame = frame
        addButton.layer.cornerRadius = 0.5 * addButton.bounds.size.width
        addButtonTabView.clipsToBounds = true
        view.addSubview(addButtonTabView)
        
        tabSelection.center.x = listButton.center.x        
    }
    

    @IBAction func listButtonTapped(_ sender: Any) {
        selectedIndex = Tab.list.rawValue
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [], animations: { 
            self.tabSelection.center.x = self.listButton.center.x
        }, completion: nil)

        
    }
    

    @IBAction func statsBarTapped(_ sender: Any) {
        selectedIndex = Tab.stats.rawValue
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [], animations: { 
            self.tabSelection.center.x = self.statsButton.center.x
        }, completion: nil)
    }
    

}

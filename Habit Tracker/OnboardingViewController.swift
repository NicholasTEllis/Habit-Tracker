//
//  OnboardingViewController.swift
//  Habit Tracker
//
//  Created by zeus on 2/23/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import PaperOnboarding
import UserNotifications

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {

    @IBOutlet weak var onboardingView: OnboardingView!

    @IBOutlet weak var notificationButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        
        onboardingView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
    let backgroundColorOne = Keys.shared.iconColor8
        let backgroundColorTwo = Keys.shared.iconColor2
        let backgroundColorThree = Keys.shared.iconColor9
        let backgroundColorFour = UIColor.white
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
<<<<<<< Updated upstream
        return [(imageName: "group_4", title: "Welcome to 21habit", description: "Don't mind our mascot, Habit Rabbit. He's happier to see you than it seems.", iconName: "", color: backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
=======
        return [(imageName: "group_4", title: "Welcome to 21habit", description: "Meet habit rabbit. Think of him as your 21-day habit development coach. Do not disappoint him.", iconName: "", color: backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
>>>>>>> Stashed changes
                
            (imageName: "OnboardingHabits", title: "How it works", description: "We're sure you've heard that it takes 21 days to form a habit. 21habit is the app that encourages you to create new ones for yourself while monitoring your progress from start to finish. It could be anything from fitness-related goals to quitting cigarettes cold turkey.", iconName: "", color: backgroundColorTwo, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            (imageName: "Onboarding3", title: "You'll get 3 strikes", description: "If you're not able to complete a habit, you'll have the option of either having your results posted to social media or donating to a charity of your choice.", iconName: "", color: backgroundColorThree, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
<<<<<<< Updated upstream
            (imageName: "notification", title: "Please allow us to notify you", description: "Turn on your notifications so that we can remind you to complete your habit challenge for that day.", iconName: "", color: Keys.shared.iconColor8, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
=======
            (imageName: "notification", title: "21habit works best with notifications", description: "Please turn on your notifications so that rabbit can remind you to complete your daily habit.", iconName: "", color: backgroundColorFour, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
>>>>>>> Stashed changes
                ][index]
        
    }
    
    
    @IBAction func notificationButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toLoginScreen", sender: self)
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, error) in
            if let error = error {
                NSLog("Error requesting authorization for notifications: \(error)")
                return
            }
        }
    }
    
    
    

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
    
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 2 {
            if self.notificationButton.alpha == 1 {
                UIView.animate(withDuration: 0.2, animations: { 
                    self.notificationButton.alpha = 0
                })
            }
        }
        
    }
    
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3 {
            UIView.animate(withDuration: 0.2, animations: {
                self.notificationButton.alpha = 1
            })
        }
    }

}

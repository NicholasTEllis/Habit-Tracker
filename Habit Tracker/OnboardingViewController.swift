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
    
    @IBOutlet weak var doneButton: UIButton!

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
    let backgroundColorOne = Keys.shared.iconColor1
        let backgroundColorTwo = Keys.shared.iconColor2
        let backgroundColorThree = Keys.shared.iconColor3
        let backgroundColorFour = Keys.shared.iconColor4
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        return [(imageName: "habit_mascot", title: "Welcome to 21habit", description: "Don't mind our mascot, Coach. He's happier to see you than it seems.", iconName: "", color: backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
                
            (imageName: "OnboardingHabits", title: "How it works", description: "We're sure you've heard that it takes 21 days to form a habit. 21habit is the app that encourages to create new ones for yourself while monitoring your progress for 21 days. It could be anything from fitness-related goals to quitting cigarettes cold turkey.", iconName: "", color: backgroundColorTwo, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            (imageName: "Onboarding3", title: "You get 3 strikes", description: "If you are not able to complete the habit we give you the option of either posting to social media or donating to a charity of your choice", iconName: "", color: backgroundColorThree, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            (imageName: "notification", title: "Please allow us to notify you", description: "Turn on your notifications so that we can remind you to complete your habit challenge for that day.", iconName: "", color: backgroundColorFour, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
                ][index]
        
    }
    
    
    @IBAction func notificationButtonTapped(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, error) in
            if let error = error {
                NSLog("Error requesting authorization for notifications: \(error)")
                return
            }
        }
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toLoginScreen", sender: self)
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
    }
    
    

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
    
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 2 {
            if self.notificationButton.alpha == 1 && self.doneButton.alpha == 1 {
                UIView.animate(withDuration: 0.2, animations: { 
                    self.notificationButton.alpha = 0
                    self.doneButton.alpha = 0
                })
            }
        }
        
    }
    
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3 {
            UIView.animate(withDuration: 0.4, animations: { 
                self.notificationButton.alpha = 1
                self.doneButton.alpha = 1
            })
        }
    }

}

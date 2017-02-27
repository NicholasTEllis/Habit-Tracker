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
        
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
       content.contentURL = URL(string: "www.21habit.io")
        content.contentTitle = "I started a new habit with 21habit"
        content.contentDescription = "Going to stop spending money on bs"
       content.imageURL = URL(string: "https://s-media-cache-ak0.pinimg.com/564x/f8/88/eb/f888ebbf1c32893934ed29b7f90cc589.jpg")
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRect(x: 100, y: 250, width: 100, height: 25)
        self.view.addSubview(button)
        
        
        updateWith()
    }
    
    //  MARK: - Properties
    
    var habit: Habit?
    
    //  MARK: - Update With
    
    func updateWith() {
        guard let habit = habit else {
            return }
        
        guard let icon = habit.icon,
            let daysCompleted = habit.habitProgress?.count,
            let progress = habit.habitProgress?.array as? [DailyCompletion] else {
                return }
        
        guard let colorKey = habit.color else {
            return }
        
        
        habitIcon.image = UIImage(named: icon)
        self.habitIcon.backgroundColor = .clear
        habitIcon.tintColor = self.colorFrom(colorKey: colorKey)
        
        daysCompletedLabel.text = "\(daysCompleted - 1) days completed"
        daysRemainingLabel.text = "\(findDaysRemaining(completedDays: daysCompleted)) days remaining"
        self.title = habit.name
        
        //strikes
        
        // MARK: - Strike Functionality
        //        var strikes = 0
        //        for day in progress {
        //            if day.isComplete == false {
        //                strikes += 1
        //            }
        //        }
        //      numberOfStrikes(from: strikes)
        
        progressView.setProgress(Float(daysCompleted / 21), animated: true)
        progressView.progressTintColor = habitIcon.tintColor
        progressView.trackTintColor = Keys.shared.background
    }
    
    
    
    
    // MARK: - Outlets
    
    @IBOutlet var habitIcon: UIImageView!
    @IBOutlet var strikeOne: UIImageView!
    @IBOutlet var strikeTwo: UIImageView!
    @IBOutlet var strikeThree: UIImageView!
    
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var daysCompletedLabel: UILabel!
    @IBOutlet var daysRemainingLabel: UILabel!
}


// MARK: - EXTENSION: Helper Methods

extension HabitDetailViewController {
    
    func findDaysRemaining(completedDays: Int) -> Int {
        return (21 - (completedDays - 1))
    }
    
    
    func numberOfStrikes(from strikes: Int) {
        
        switch strikes {
        case 1:
            strikeOne.tintColor = Keys.shared.iconColor5
        case 2:
            strikeOne.tintColor = Keys.shared.iconColor5
            strikeTwo.tintColor = Keys.shared.iconColor5
        case 3:
            strikeOne.tintColor = Keys.shared.iconColor5
            strikeTwo.tintColor = Keys.shared.iconColor5
            strikeThree.tintColor = Keys.shared.iconColor5
        default:
            return
        }
    }
    
    
    func colorFrom(colorKey: String) -> UIColor {
        switch colorKey {
        case "iconColor1":
            return Keys.shared.iconColor1
        case "iconColor2" :
            return Keys.shared.iconColor2
        case "iconColor3" :
            return Keys.shared.iconColor3
        case "iconColor4" :
            return Keys.shared.iconColor4
        case "iconColor5" :
            return Keys.shared.iconColor5
        case "iconColor6" :
            return Keys.shared.iconColor6
        default:
            return Keys.shared.iconColor7
        }
    }
    
    
    
}

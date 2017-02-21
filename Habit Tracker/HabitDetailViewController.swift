//
//  HabitDetailViewController.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/20/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class HabitDetailViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let habit = self.habit {
            self.updateWith(habit: habit)
        }
    }

    var habit: Habit?
    
    
    
    func updateWith(habit: Habit) {
        guard let icon = habit.icon,
            let daysCompleted = habit.habitProgress?.count,
            let progress = habit.habitProgress?.array as? [DailyCompletion] else { return }
        
        guard let colorKey = habit.color else { return }
        
        
        habitIcon.image = UIImage(named: icon)
        self.habitIcon.backgroundColor = .clear
        habitIcon.tintColor = self.colorFrom(colorKey: colorKey)
        
        daysCompletedLabel.text = "\(daysCompleted) / 21"
        daysRemainingLabel.text = "\(findDaysRemaining(completedDays: daysCompleted))"
        self.title = habit.name
        
        //strikes
        var strikes = 0
        for day in progress {
            if day.isComplete == false {
                strikes += 1
            }
        }
        numberOfStrikes(from: strikes)
        
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
        return (21 - completedDays)
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

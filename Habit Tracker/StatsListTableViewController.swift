//
//  StatsListTableViewController.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/24/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class StatsListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var bestStreakLabel: UILabel!
    @IBOutlet weak var totalCompletedLabel: UILabel!
    @IBOutlet weak var currentPerfectStreakLabel: UILabel!
    @IBOutlet weak var totalPerfectHabitsLabel: UILabel!
    @IBOutlet weak var totalPerfectDaysLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Keys.shared.background
        
        bestStreakLabel.textColor = Keys.shared.textColor
        bestStreakLabel.text = "Best Streak: \(User.bestStreak)"
        totalCompletedLabel.textColor = Keys.shared.textColor
        totalCompletedLabel.text = "Habits Completed: \(User.completedHabits)"
        currentPerfectStreakLabel.textColor = Keys.shared.textColor
        currentPerfectStreakLabel.text = "Current Perfect Day Streak: \(User.currentStreak)"
        totalPerfectHabitsLabel.textColor = Keys.shared.textColor
        totalPerfectHabitsLabel.text = "Total Perfect Habits: \(user.perfectHabits)"
        totalPerfectDaysLabel.textColor = Keys.shared.textColor
        totalPerfectDaysLabel.text = "Total Perfect Days: \(user.perfectDays)"
    }
}

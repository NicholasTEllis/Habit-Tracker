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
        
        let user = UserController.shared.user
        
        bestStreakLabel.textColor = Keys.shared.textColor
        bestStreakLabel.text = "Best Streak: \(user.bestStreak)"
        bestStreakLabel.font = Keys.shared.font
        totalCompletedLabel.textColor = Keys.shared.textColor
        totalCompletedLabel.text = "Habits Completed: \(user.completedHabits)"
        totalCompletedLabel.font = Keys.shared.font
        currentPerfectStreakLabel.textColor = Keys.shared.textColor
        currentPerfectStreakLabel.text = "Current Perfect Day Streak: \(user.currentStreak)"
        currentPerfectStreakLabel.font = Keys.shared.font
        totalPerfectHabitsLabel.textColor = Keys.shared.textColor
        totalPerfectHabitsLabel.text = "Total Perfect Habits: \(user.perfectHabits)"
        totalPerfectHabitsLabel.font = Keys.shared.font
        totalPerfectDaysLabel.textColor = Keys.shared.textColor
        totalPerfectDaysLabel.text = "Total Perfect Days: \(user.perfectDays)"
        totalPerfectDaysLabel.font = Keys.shared.font
    }
}

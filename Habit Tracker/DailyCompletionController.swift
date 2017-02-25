//
//  DailyCompletionController.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/20/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation

class DailyCompletionController {
    
    static let shared = DailyCompletionController()
    
    // MARK: - Daily Completion Methods 
    
    func completeHabitForDay(habit: Habit) {
        let today = habit.habitProgress?.lastObject as? DailyCompletion
        today?.completedDay = NSDate()
        habit.isCompleteToday = true
        HabitController.shared.saveToPersistentStore()
    }
    
    func undoCompleteHabitForDay(habit: Habit) {
        guard let today = habit.habitProgress?.lastObject as? DailyCompletion else { return }
        today.completedDay = NSDate()
        habit.managedObjectContext?.delete(today)
        habit.isCompleteToday = false
        HabitController.shared.saveToPersistentStore()
    }
    
    // TODO: - fail remaining habits, check for failed & completed habits, and do whatever it is we do with non completed array
    func endOfDayCompletions() {
        let user = UserController.shared.user
        var addToUserPerfectStreak = true
        for habit in HabitController.shared.habits {
            
            if !habit.isCompleteToday {
                addToUserPerfectStreak = false
            }
            guard let completedDays = habit.habitProgress?.count else { return }
            if (completedDays + habit.strikes) == 21 {
                // TODO: - prompt extension, congratulate, post, etc
            
            } else {
                habit.isCompleteToday = false
            }
        }
        
        if addToUserPerfectStreak {
            user.perfectDays += 1
            user.currentStreak += 1
            if user.currentStreak > user.bestStreak {
                user.bestStreak += 1
            } else {
                user.currentStreak = 0
            }
        }
        UserController.shared.saveToPersistentStore()
        
        // TODO: - reload habitListTableViewController somewhere
    }
}

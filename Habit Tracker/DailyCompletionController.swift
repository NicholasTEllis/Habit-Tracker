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
    }
    
    func undoCompleteHabitForDay(habit: Habit) {
        guard let today = habit.habitProgress?.lastObject as? DailyCompletion else { return }
        today.completedDay = NSDate()
        habit.managedObjectContext?.delete(today)
        habit.isCompleteToday = false
    }
    
    // TODO: - fail remaining habits, check for failed & completed habits, and do whatever it is we do with non completed array
    func endOfDayCompletions() {
        for habit in HabitController.shared.habits {
            // TODO: - make this calculate number of days since start
            if habit.habitProgress?.count == 21 {
                // TODO: - prompt extension, congratulate, post, etc
            
            } else {
                habit.isCompleteToday = false
            }
        }
        // TODO: - reload habitListTableViewController somewhere
    }
}

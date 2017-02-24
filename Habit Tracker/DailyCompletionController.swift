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
        _ = DailyCompletion(completedDay: NSDate(), habit: habit)
        habit.isCompleteToday = true
        HabitController.shared.saveToPersistentStore()
    }
    
    func undoCompleteHabitForDay(habit: Habit) {
        let undoCompleteDay = DailyCompletion(completedDay: NSDate(), habit: habit)
        habit.managedObjectContext?.delete(undoCompleteDay)
        habit.isCompleteToday = false
        HabitController.shared.saveToPersistentStore()
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

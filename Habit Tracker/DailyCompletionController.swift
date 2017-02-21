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
    
    func createCompletion(habit: Habit) {
        _ = DailyCompletion(isComplete: false, habit: habit)
    }
    
    func completeHabitForDay(habit: Habit) {
        let today = habit.habitProgress?.lastObject as? DailyCompletion
        today?.isComplete = true
        habit.isCompleteToday = true
    }
    
    func undoCompleteHabitForDay(habit: Habit) {
        let today = habit.habitProgress?.lastObject as? DailyCompletion
        today?.isComplete = false
        habit.isCompleteToday = false
    }
    
    // TODO: - fail remaining habits, check for failed & completed habits, and do whatever it is we do with non completed array
    func endOfDayCompletions() {
        for habit in HabitController.shared.habits {
            if habit.habitProgress?.count == 21 {
                // TODO: - prompt extension, congratulate, post, etc
            } else {
                createCompletion(habit: habit)
                habit.isCompleteToday = false
            }
        }
        // TODO: - reload habitListTableViewController somewhere
    }
    
}

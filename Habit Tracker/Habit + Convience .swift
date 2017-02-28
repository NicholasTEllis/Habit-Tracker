//
//  Habit + Convience .swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Habit {
    
    convenience init(name: String, icon: String, startDate: NSDate = NSDate(), timeOfNotification: String, color: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.icon = icon
        self.startDate = startDate
        self.timeOfNotification = timeOfNotification
        self.color = color
    }
    
    // Computed Properties
    
    
//    var fireDate: NSDate? {
//        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return nil }
//        let fireDateFromThisMorning = NSDate(timeInterval: asdf, since: thisMorningAtMidnight)
//        return fireDateFromThisMorning
//    }
    
    var strikes: Int {
        let calendar = NSCalendar.current
        guard let startDate = self.startDate as? Date else {
            return 0 }
        
        let start = calendar.startOfDay(for: startDate)
        let current = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: start, to: current)
        guard let daysSinceStart = components.day else {
            return 0
        }
        var expectedCompletions = daysSinceStart
        if !self.isCompleteToday {
            expectedCompletions -= 1
        }
        guard let habitCount = self.habitProgress?.count else { return 0 }
        let strikedDays = expectedCompletions - habitCount
        return strikedDays
    }
    
    var streaks: [Int] {
        var streak = 0
        var bestStreak = 0
        guard let progress = self.habitProgress?.array as? [DailyCompletion] else {
            print("Habit completions do not contain any DailyCompletion objects.")
            return [0, 0] }
        
        var compareDate = progress.first?.completedDay as? Date
        
        let calendar = Calendar.current
        
        for completed in progress {
            guard let lastCompletedDate = completed.completedDay as? Date else { return [0, 0] }
            guard let dateToCompare = compareDate else { return [0, 0] }
            let components = Calendar.Component.day
            if calendar.isDate(dateToCompare, equalTo: lastCompletedDate, toGranularity: components) {
                streak += 1
                compareDate = calendar.date(bySetting: .day, value: 1, of: dateToCompare)
                if streak > bestStreak {
                    bestStreak = streak
                }
            } else {
                streak = 0
                compareDate = completed.completedDay as? Date
            }
        }
        return [streak, bestStreak]
    }
}

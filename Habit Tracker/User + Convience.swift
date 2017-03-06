//
//  User + Convience.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/23/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import CoreData

extension User {
    convenience init(perfectDays: Int16, bestStreak: Int16 = 0, completedHabits: Int16 = 0, currentStreak: Int16 = 0, perfectHabits: Int16 = 0, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.perfectDays = perfectDays
        self.bestStreak = bestStreak
        self.completedHabits = completedHabits
        self.currentStreak = currentStreak
        self.perfectHabits = perfectHabits
    }
}

//
//  DailyCompletion + Convience .swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import CoreData

extension DailyCompletion {
    convenience init(completedDay: NSDate, habit: Habit, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.completedDay = completedDay
        self.habit = habit
    }
}

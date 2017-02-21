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
    convenience init(isComplete: Bool, habit: Habit, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.isComplete = isComplete
        self.habit = habit
    }
}

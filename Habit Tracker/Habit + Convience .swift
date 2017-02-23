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
}

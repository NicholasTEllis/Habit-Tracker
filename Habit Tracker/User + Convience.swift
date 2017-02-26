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
    
    convenience init(morningTime: NSDate, afternoonTime: NSDate, eveningTime: NSDate, anyTime: NSDate, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.morningTime = morningTime
        self.afternoonTime = afternoonTime
        self.eveningTime = eveningTime
        self.anyTime = anyTime
    }
}

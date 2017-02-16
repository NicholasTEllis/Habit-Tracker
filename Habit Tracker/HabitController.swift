//
//  HabitController.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class HabitController {
    
    static let shared = HabitController()

    var habits: [Habit] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }

    func addHabit(name: String, imageName: String, startDate: NSDate = NSDate(), timeOfNotification: String) {
        _ = Habit(name: name, icon: imageName, startDate: startDate, timeOfNotification: timeOfNotification)
        saveToPersistentStore()
    }
    
    //this will be to choose 21 then onto 66 days
    func durationOfHabit() {
        
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            NSLog("There was a problem saving to coredata: \(error)")
        }
    }
}

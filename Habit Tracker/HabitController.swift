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
import UserNotifications

class HabitController {
    
    static let shared = HabitController()
    
    fileprivate static let userNotificationIdentifier = "habitNotification"

    var habits: [Habit] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }

    func addHabit(name: String, imageName: String, startDate: NSDate = NSDate(), timeOfNotification: String) -> Habit {
        let habit = Habit(name: name, icon: imageName, startDate: startDate, timeOfNotification: timeOfNotification)
        return habit
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

protocol HabitNotificationScheduler {
    func scheduleLocalNotifications(_ habit: Habit)
    func cancelLocalNotifications(_ habit: Habit)
}

extension HabitNotificationScheduler {
    
    func scheduleLocalNotifications(_ habit: Habit) {
        guard let name = habit.name else {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "\(name)"
        content.body = "Finish Your Habit Today!"
        content.categoryIdentifier = "message"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([], from: <#T##Date#>)
        let request = UNNotificationRequest(identifier: HabitController.userNotificationIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func cancelLocalNotifications(_ habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [HabitController.userNotificationIdentifier])
    }
}

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
    
    // MARK: - Internal Properties
    
    fileprivate static let userNotificationIdentifier = "habitNotification"

    var habits: [Habit] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    static var fireDateFromTimeOfNotification: Date? {
        let timeWindowFromSettings = SettingsViewController.morning
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight,
        let timeFromSettings = Double(timeWindowFromSettings) else { return nil }
        let timeInterval: TimeInterval = timeFromSettings
        let fireDateFromThisMorning = Date(timeInterval: timeInterval, since: thisMorningAtMidnight)
        return fireDateFromThisMorning
    }
    
    //  MARK: - Habit Methods

    func addHabit(name: String, imageName: String, startDate: NSDate = NSDate(), timeOfNotification: String, color: String) -> Habit {
        let habit = Habit(name: name, icon: imageName, startDate: startDate, timeOfNotification: timeOfNotification, color: color)
        return habit
    }
    
     //  MARK: - Persistence
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            NSLog("There was a problem saving to coredata: \(error)")
        }
    }
}

 //  MARK: - Push Notifications

protocol HabitNotificationScheduler {
    func scheduleLocalNotifications(_ habit: Habit)
    func cancelLocalNotifications(_ habit: Habit)
}

extension HabitNotificationScheduler {
    
    func scheduleLocalNotifications(_ habit: Habit) {
        guard let name = habit.name, let fireDate = HabitController.fireDateFromTimeOfNotification else {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "\(name)"
        content.body = "Finish Your Habit Today!"
        content.categoryIdentifier = "message"
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: fireDate)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: HabitController.userNotificationIdentifier, content: content, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func cancelLocalNotifications(_ habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [HabitController.userNotificationIdentifier])
    }
}

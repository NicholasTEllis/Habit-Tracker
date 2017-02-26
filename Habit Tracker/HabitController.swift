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
    
    let notifications: HabitNotificationScheduler?

    var habits: [Habit] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //  MARK: - Habit Methods

    func addHabit(name: String, imageName: String, timeOfNotification: String, color: String) -> Habit {
        let habit = Habit(name: name, icon: imageName, timeOfNotification: timeOfNotification, color: color)
        notifications?.scheduleLocalNotifications(habit, date: )
        saveToPersistentStore()
        return habit
    }
    
    func setupTimeForNotifications(habit: Habit) {
        switch habit.timeOfNotification {
        case "Morning"?:
            habit.timeOfNotification = SettingsViewController.morning
        case "Afternoon"?:
            habit.timeOfNotification = SettingsViewController.afternoon
        case "Evening"?:
            habit.timeOfNotification = SettingsViewController.evening
        case "Any"?:
            habit.timeOfNotification = SettingsViewController.any
        default:
            habit.timeOfNotification = SettingsViewController.any
        }
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
    func scheduleLocalNotifications(_ habit: Habit, date: Date)
    func cancelLocalNotifications(_ habit: Habit)
}

extension HabitNotificationScheduler {

    func scheduleLocalNotifications(_ habit: Habit, date: Date) {
        guard let name = habit.name else {
                return
        }
        let content = UNMutableNotificationContent()
        content.title = "\(name)"
        content.body = "Finish Your Habit Today!"
        content.categoryIdentifier = "dailyHabit"
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: HabitController.userNotificationIdentifier, content: content, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func cancelLocalNotifications(_ habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [HabitController.userNotificationIdentifier])
    }
}

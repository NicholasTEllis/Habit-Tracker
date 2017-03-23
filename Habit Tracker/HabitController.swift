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
import FBSDKCoreKit
import FBSDKShareKit
import GameKit

class HabitController {
    
    static let shared = HabitController()
    
    // MARK: - Internal Properties
    
    fileprivate static let userNotificationIdentifier = "dailyHabit"
    
    var habits: [Habit] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //  MARK: - Habit Methods
    
    func addHabit(name: String, imageName: String, timeOfNotification: String, color: String) -> Habit {
        let habit = Habit(name: name, icon: imageName, timeOfNotification: timeOfNotification, color: color)
        scheduleLocalNotifications(habit)
        saveToPersistentStore()
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
    
    // MARK: - Local Notifications
    
    func updateLocalNotifcations(habit: Habit, fireTime: TimeInterval) {
       // habit.fireTimeOfNotification = fireTime
        scheduleLocalNotifications(habit)
        saveToPersistentStore()
    }
    
    func scheduleLocalNotifications(_ habit: Habit) {
        
        guard let name = habit.name,
            let fireDate = habit.fireDate  else {
                return
        }
        let content = UNMutableNotificationContent()
        content.title = "\(name)"
        content.body = "Finish Your Habit Today!"
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fireDate as Date)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: HabitController.userNotificationIdentifier, content: content, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("\(error?.localizedDescription)")
                print("\(error)")
                print("There was an error an Nick sucks")
            }
        }
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            for request in requests {
                print("\(request.trigger)")
            }
        }
    }
    
    func cancelLocalNotifications(_ habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [HabitController.userNotificationIdentifier])
    }
    
    //  MARK: - Generate Random Qoutes 
    
//    var qoutes: [String] = []
//    
//    func createArray() {
//        guard let path = Bundle.main.path(forResource: "qoutes", ofType: "json") else { return }
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            
//            guard let array = jsonObj as? [String] else {
//                return }
//            for i in array {
//                qoutes.append(i)
//            }
//        } catch {
//            NSLog(error.localizedDescription)
//        }
//    }
//    
//    func randomQoutes(qoutes: [String]) -> [String] {
//        _ = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: qoutes)
//        return qoutes
//    }
}

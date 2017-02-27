//
//  UserController.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/23/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    static let shared = UserController()
    
    var user: User {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? CoreDataStack.context.fetch(request)) ?? []
        guard let user = users.first else {
            fatalError("User object does not exist")
        }
        return user
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    func createUser()  {
        guard let morningTime = dateFormatter.date(from: "09:00"),
            let afternoonTime = dateFormatter.date(from: "12:00"),
            let eveningTime = dateFormatter.date(from: "17:00"),
            let anytime = dateFormatter.date(from: "13:00") else {
            return
        }
        _ = User(morningTime: morningTime as NSDate, afternoonTime: afternoonTime as NSDate, eveningTime: eveningTime as NSDate, anyTime: anytime as NSDate)
        updateUserTimes()
        saveToPersistentStore()
    }
    
    func updateUserTimes() {
        user.morningTime = SettingsViewController.morning
        user.afternoonTime = SettingsViewController.afternoon
        user.eveningTime = SettingsViewController.evening
        user.anyTime = SettingsViewController.any
//        SettingsViewController.morning = user.morningTime
//        SettingsViewController.afternoon = user.afternoonTime
//        SettingsViewController.evening = user.eveningTime
//        SettingsViewController.any = user.anyTime
//        
        saveToPersistentStore()
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

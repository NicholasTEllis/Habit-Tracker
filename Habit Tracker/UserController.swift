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
  
    func createUser()  {
        _ = User()
        saveToPersistentStore()
    }
    
    func updateUserTimes(withDate: NSDate) {
       //SettingsViewController.morning = user.morningTime
        //SettingsViewController.afternoon = user.afternoonTime
        //SettingsViewController.evening = user.eveningTime
        //SettingsViewController.any = user.anyTime
        user.morningTime = SettingsViewController.morning
        user.afternoonTime = SettingsViewController.afternoon
        user.eveningTime = SettingsViewController.evening
        user.anyTime = SettingsViewController.any
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

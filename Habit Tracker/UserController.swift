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
    
    func createUserTime(morningTime: NSDate, afternoonTime: NSDate, eveningTime: NSDate, anyTime: NSDate) -> User {
        let user = User(morningTime: morningTime, afternoonTime: afternoonTime, eveningTime: eveningTime, anyTime: anyTime)
        saveToPersistentStore()
        return user
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

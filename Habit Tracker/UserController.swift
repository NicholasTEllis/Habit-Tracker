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
        guard let user = users.first else { return User() }
        return user
    }
    
    func createUser(morningTime: String = "9:00 AM", afternoonTime: String = "12:00 PM", eveningTime: String = "5:00 PM", anyTime: String = "1:00 PM") -> User {
        let user = User(morningTime: morningTime, afternoonTime: afternoonTime, eveningTime: eveningTime, anyTime: anyTime)
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

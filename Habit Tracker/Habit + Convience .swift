//
//  Habit + Convience .swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Habit {
    
//    var photo: UIImage {
//        guard let data = icon, let image = UIImage(data: data as Data) else {
//        return UIImage()
//        }
//        return image
//    }
    
    convenience init(name: String, icon: NSData, startDate: NSDate, timeOfNotification: NSDate, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.icon = icon
        self.startDate = startDate
        self.timeOfNotification = timeOfNotification
    }
}

//
//  TimeSettingsController.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/28/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation

class TimeSettingsController {
    
    static let shared = TimeSettingsController()
    
    var fireTimes: [TimeSettings] = []
    
    fileprivate let kFireTime = "fireTimes"
    
    func savedToPersisentStore() {
        let userDefaults = UserDefaults.standard
        let fireTimeDictionary = fireTimes.map{$0.dictionaryRep}
        userDefaults.set(fireTimeDictionary, forKey: kFireTime)
    }
    
    func loadFromStore() {
        let userDefaults = UserDefaults.standard
        guard let fireTimeDictionary = userDefaults.object(forKey: kFireTime) as? [[String : Any]] else {
            return
        }
        
        fireTimes = fireTimeDictionary.flatMap{TimeSettings(dictionary: $0)}
    }
}

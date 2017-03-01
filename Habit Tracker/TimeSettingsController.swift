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
    
    fileprivate let kMorning = "morning"
    fileprivate let kAfternoon = "afternoon"
    fileprivate let kEvening = "evening"
    fileprivate let kAnytime = "anytime"
    
    var morning: TimeInterval {
        didSet {
            saveToPersisentStore()
        }
    }
    
    var afternoon: TimeInterval {
        didSet {
            saveToPersisentStore()
        }
    }
    
    var evening: TimeInterval {
        didSet {
            saveToPersisentStore()
        }
    }
    
    var anytime: TimeInterval {
        didSet {
            saveToPersisentStore()
        }
    }
    
    init() {
        self.morning = UserDefaults.standard.object(forKey: kMorning) as? TimeInterval ?? 32400.0
        self.afternoon = UserDefaults.standard.object(forKey: kAfternoon) as? TimeInterval ?? 43200.0
        self.evening = UserDefaults.standard.object(forKey: kEvening) as? TimeInterval ?? 54000.0
        self.anytime = UserDefaults.standard.object(forKey: kAnytime) as? TimeInterval ?? 43200.0
        loadFromStore()
    }
    
    func saveToPersisentStore() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(morning, forKey: kMorning)
        userDefaults.set(afternoon, forKey: kAfternoon)
        userDefaults.set(evening, forKey: kEvening)
        userDefaults.set(anytime, forKey: kAnytime)
    }
    
    func loadFromStore() {
        let userDefaults = UserDefaults.standard
        userDefaults.double(forKey: kMorning)
        userDefaults.double(forKey: kAfternoon)
        userDefaults.double(forKey: kEvening)
        userDefaults.double(forKey: kAnytime)
    }
}

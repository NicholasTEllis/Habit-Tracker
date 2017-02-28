//
//  TimeSettings.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/28/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation

class TimeSettings {
    
    fileprivate let kMorning = "morning"
    fileprivate let kAfternoon = "afternoon"
    fileprivate let kEvening = "evening"
    fileprivate let kAnytime = "anytime"
    
    var morning: TimeInterval {
        didSet {
            savedToPersisentStore()
        }
    }
    
    var afternoon: TimeInterval {
        didSet {
            savedToPersisentStore()
        }
    }
    
    var evening: TimeInterval {
        didSet {
            TimeSettingsController.shared.savedToPersisentStore()
        }
    }
    
    var anytime: TimeInterval {
        didSet {
            savedToPersisentStore()
        }
    }
    
    init(morning: TimeInterval, afternoon: TimeInterval, evening: TimeInterval, anytime: TimeInterval) {
        self.morning = morning
        self.afternoon = afternoon
        self.evening = evening
        self.anytime = anytime
    }
    
    var dictionaryRep: [String : Any] {
        return [kMorning : morning, kAfternoon : afternoon, kEvening : evening, kAnytime : anytime]
    }
    
    init?(dictionary: [String : Any]) {
        guard let morning = dictionary[kMorning] as? TimeInterval,
            let afternoon = dictionary[kAfternoon] as? TimeInterval,
            let evening = dictionary[kEvening] as? TimeInterval,
            let anytime = dictionary[kAnytime] as? TimeInterval else {
                return nil
        }
        
        self.morning = morning
        self.afternoon = afternoon
        self.evening = evening
        self.anytime = anytime
    }

}

//
//  DateHelper.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/20/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation

class DateHelper {
    
    static var calendar: Calendar {
        return Calendar.current
    }
    
    static var thisMorningAtMidnight: Date? {
        var components = calendar.dateComponents([.month, .day, .year], from: Date())
        components.second = 0
        components.minute = 0
        components.hour = 0
        components.nanosecond = 0
        return calendar.date(from: components)
    }
    
    static var tomorrowMorningAtMidnight: Date? {
        var components = calendar.dateComponents([.month, .day, .year], from: Date())
        components.second = 0
        components.minute = 0
        components.hour = 0
        components.nanosecond = 0
        guard let date = calendar.date(from: components) else {return nil}
        return Date(timeInterval: 24*60*60, since: date)
    }
    
    static func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        var ti = Int(interval)
        var anteMeridiem = "AM"
        
        if ti >= 43200 {
            anteMeridiem = "PM"
        }
        
        if ti >= 46800 {
            ti -= 43200
        }
        
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%2d:%02d \(anteMeridiem)",hours,minutes)
    }
}

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
        var components = (calendar as Calendar).dateComponents([.month, .day, .year], from: Date())
        components.second = 0
        components.minute = 0
        components.hour = 0
        components.nanosecond = 0
        return calendar.date(from: components)
    }
    
    static var tomorrowMorningAtMidnight: Date? {
        var components = (calendar as Calendar).dateComponents([.month, .day, .year], from: Date())
        components.second = 0
        components.minute = 0
        components.hour = 0
        components.nanosecond = 0
        guard let date = calendar.date(from: components) else {return nil}
        return Date(timeInterval: 24*60*60, since: date)
    }
}

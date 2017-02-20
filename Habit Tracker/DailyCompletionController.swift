//
//  DailyCompletionController.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/20/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation

class DailyCompletionController {
    
    static let shared = DailyCompletionController()
    
    func createCompletion(isComplete: Bool, habit: Habit) {
        _ = DailyCompletion(isComplete: isComplete, habit: habit)
    }
    
}

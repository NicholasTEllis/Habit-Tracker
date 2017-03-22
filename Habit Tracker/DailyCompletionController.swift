//
//  DailyCompletionController.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/20/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import UIKit

class DailyCompletionController {
    
    static let shared = DailyCompletionController()
    
    // MARK: - Daily Completion Methods 
    
    func completeHabitForDay(habit: Habit) {
        _ = DailyCompletion(completedDay: NSDate(), habit: habit)
        habit.isCompleteToday = true
        HabitController.shared.saveToPersistentStore()
    }
    
    func undoCompleteHabitForDay(habit: Habit) {
        guard let completion = habit.habitProgress?.lastObject as? DailyCompletion else { return }
        if let moc = completion.managedObjectContext {
            moc.delete(completion)
            habit.isCompleteToday = false
        }
        HabitController.shared.saveToPersistentStore()
    }
    
    // TODO: - fail remaining habits, check for failed & completed habits, and do whatever it is we do with non completed array
    func endOfDayCompletions() {
        let user = UserController.shared.user
        var addToUserPerfectStreak = true
        for habit in HabitController.shared.habits {
            
            if !habit.isCompleteToday {
                addToUserPerfectStreak = false
            }
            guard let completedDays = habit.habitProgress?.count else { return }
            if habit.strikes >= 3 {
                strikeOutCompletion(habit: habit)
            } else if (completedDays + habit.strikes) >= 21 {
                finalHabitCompletion(habit: habit)
            } else {
                habit.isCompleteToday = false
            }
        }
        
        // if all habits for the day are completed, add to the appropriate user streaks
        if addToUserPerfectStreak {
            user.perfectDays += 1
            user.currentStreak += 1
            if user.currentStreak > user.bestStreak {
                user.bestStreak += 1
            } else {
                user.currentStreak = 0
            }
        }
        UserController.shared.saveToPersistentStore()
        
        // TODO: - reload habitListTableViewController somewhere
    }
    
    // TODO: - Make this function do more completion stuff, like prompt a post
    func finalHabitCompletion(habit: Habit) {
        let user = UserController.shared.user
        user.completedHabits += 1

        if habit.habitProgress?.count == 21 {
            user.perfectDays += 1
            
            let perfectCompletionAlert = UIAlertController(title: "Wow! Way to go!", message: "You finished your habit titled \(habit.name) without missing a single day!", preferredStyle: .alert)
            let shareAction = UIAlertAction(title: "Share", style: .default) { (_) in
                // TODO: - share to facebook here
                
                if let moc = habit.managedObjectContext {
                    moc.delete(habit)
                }
        }
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                if let moc = habit.managedObjectContext {
                    moc.delete(habit)
                }
            }
            
            perfectCompletionAlert.addAction(shareAction)
            perfectCompletionAlert.addAction(okAction)
            
            var rootViewController = UIApplication.shared.keyWindow?.rootViewController
            if let navigationController = rootViewController as? UINavigationController {
                rootViewController = navigationController.viewControllers.first
            }
            if let tabBarController = rootViewController as? UITabBarController {
                rootViewController = tabBarController.selectedViewController
            }
            rootViewController?.present(perfectCompletionAlert, animated: true)
            return
        }
        
        let completionAlert = UIAlertController(title: "Good work!", message: "You finished your habit titled \(habit.name)!", preferredStyle: .alert)
        let shareAction = UIAlertAction(title: "Share", style: .default) { (_) in
            // TODO: - share to facebook here
            
            if let moc = habit.managedObjectContext {
                moc.delete(habit)
            }
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let moc = habit.managedObjectContext {
                moc.delete(habit)
            }
        }
        
        completionAlert.addAction(shareAction)
        completionAlert.addAction(okAction)
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(completionAlert, animated: true)
    }

    func strikeOutCompletion(habit: Habit) {
        let youFailAlert = UIAlertController(title: "Oh No!", message: "You got 3 strikes on your habit titled \(habit.name). Would you like to re-start?", preferredStyle: .alert)
        let giveUpAction = UIAlertAction(title: "Give up", style: .destructive) { (_) in
            if let moc = habit.managedObjectContext {
                moc.delete(habit)
            }
        }
        let restartAction = UIAlertAction(title: "Restart", style: .default) { (_) in
            guard let color = habit.color,
            let timeOfNotification = habit.timeOfNotification,
            let icon = habit.icon,
            let name = habit.name else { return }
            HabitController.shared.addHabit(name: name, imageName: icon, timeOfNotification: timeOfNotification, color: color)
            if let moc = habit.managedObjectContext {
                moc.delete(habit)
            }
        }
        
        youFailAlert.addAction(giveUpAction)
        youFailAlert.addAction(restartAction)
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(youFailAlert, animated: true)
    }
}

//
//  HabitDetailViewController.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/20/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit


class HabitDetailViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = FBSDKShareLinkContent()
        let button = FBSDKShareButton()
        button.shareContent = content
        button.center = self.view.center
        self.view.addSubview(button)
        content.contentURL = URL(string: "https://developers.facebook.com")
        let dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.mode = .shareSheet
        
        
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        updateWith()
    }
    

    //  MARK: - Update With
    
    func updateWith() {
        guard let habit = habit else {
            return }
        
        guard let icon = habit.icon,
            let daysCompleted = habit.habitProgress?.count,
            let progress = habit.habitProgress?.array as? [DailyCompletion],
            let colorKey = habit.color else {
                return }

        habitIcon.image = UIImage(named: icon)
        self.habitIcon.backgroundColor = .clear
        habitIcon.tintColor = self.colorFrom(colorKey: colorKey)
        
        if daysCompleted - 1 != 0 {
            daysCompletedLabel.text = "\(daysCompleted - 1) days completed"
        } else {
            daysCompletedLabel.text = ""
        }
        
        daysRemainingLabel.text = "\(findDaysRemaining(completedDays: daysCompleted)) days remaining"
        self.title = habit.name
        
        //strikes
        
        // MARK: - Strike Functionality
        //        var strikes = 0
        //        for day in progress {
        //            if day.isComplete == false {
        //                strikes += 1
        //            }
        //        }
        //      numberOfStrikes(from: strikes)
        
        progressView.setProgress(Float(daysCompleted / 21), animated: true)
        progressView.progressTintColor = habitIcon.tintColor
        progressView.trackTintColor = Keys.shared.background
    }
    
    
    //  MARK: - Properties
    
    var habit: Habit?
    
    var habitDuration = [Date]()
    
    let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0) // for colelction view

    let dayNameFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter
    }()
    
    let dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter
    }()
    
    let monthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM  yyyy"
        return dateFormatter
    }()
    
    
    
    // MARK: - Outlets
    
    @IBOutlet var habitIcon: UIImageView!
    @IBOutlet var strikeOne: UIImageView!
    @IBOutlet var strikeTwo: UIImageView!
    @IBOutlet var strikeThree: UIImageView!
    
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var daysCompletedLabel: UILabel!
    @IBOutlet var daysRemainingLabel: UILabel!
    
    @IBOutlet var calendarCollectionView: UICollectionView!
    
    
}

// MARK: - Extension: UICollectionView 

extension HabitDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitDuration.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calanderDate", for: indexPath) as? CalendarCollectionViewCell
        let date = habitDuration[indexPath.row]
        let dayName = dayNameFormatter.string(from: date)
        let day = dayFormatter.string(from: date)
        cell?.dayButton.setTitle(day, for: .normal)
        cell?.dayName.text = dayName
        return cell ?? UICollectionViewCell()
    }

}


// MARK: - EXTENSION: Helper Methods

extension HabitDetailViewController {
    
    func findDaysRemaining(completedDays: Int) -> Int {
        return (21 - (completedDays - 1))
    }
    
    
    func numberOfStrikes(from strikes: Int) {
        switch strikes {
        case 1:
            strikeOne.tintColor = Keys.shared.iconColor5
        case 2:
            strikeOne.tintColor = Keys.shared.iconColor5
            strikeTwo.tintColor = Keys.shared.iconColor5
        case 3:
            strikeOne.tintColor = Keys.shared.iconColor5
            strikeTwo.tintColor = Keys.shared.iconColor5
            strikeThree.tintColor = Keys.shared.iconColor5
        default:
            return
        }
    }
    
    
    func colorFrom(colorKey: String) -> UIColor {
        switch colorKey {
        case "iconColor1":
            return Keys.shared.iconColor1
        case "iconColor2" :
            return Keys.shared.iconColor2
        case "iconColor3" :
            return Keys.shared.iconColor3
        case "iconColor4" :
            return Keys.shared.iconColor4
        case "iconColor5" :
            return Keys.shared.iconColor5
        case "iconColor6" :
            return Keys.shared.iconColor6
        default:
            return Keys.shared.iconColor7
        }
    }
    
    
    func findLengthOf(habit: Habit) {
        guard let startDateForHabit = habit.startDate as? Date else {
            return }
        let cal = Calendar.current
        let startDate = startDateForHabit
        let today = Date()
        while startDate <= today {
            guard let daysBetween = cal.date(byAdding: .day, value: 1, to: startDate) else {
                return }
            habitDuration.append(daysBetween)
        }
    }
    
}















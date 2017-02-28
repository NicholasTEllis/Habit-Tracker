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
        
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: "")
        content.contentTitle = "I started a new habit with 21habit"
        content.contentDescription = "Create better habits for yourself with 21habit. It's free on the app store!"
        content.imageURL = URL(string: "https://s-media-cache-ak0.pinimg.com/564x/f8/88/eb/f888ebbf1c32893934ed29b7f90cc589.jpg")
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRect(x: 100, y: 250, width: 100, height: 25)
        self.view.addSubview(button)
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        updateWith()
        
        habitLengthInDays()
        addDatesSinceSunday()
        
        monthLabel.text = monthFormatter.string(from: Date())
    }
    
    
    //  MARK: - Main Methods
    
    func updateWith() {
        guard let habit = habit else {
            return }
        
        guard let icon = habit.icon,
            let daysCompleted = habit.habitProgress?.count,
            let progress = habit.habitProgress?.array as? [DailyCompletion],
            let colorKey = habit.color else { return }
        
        habitIcon.image = UIImage(named: icon)
        self.habitIcon.backgroundColor = .clear
        habitIcon.tintColor = self.colorFrom(colorKey: colorKey)
        
        if daysCompleted != 0 {
            daysCompletedLabel.text = "\(daysCompleted) days completed"
        } else {
            daysCompletedLabel.text = ""
        }
        
        daysRemainingLabel.text = "\(findDaysRemaining(completedDays: daysCompleted + 1)) days remaining"
        self.title = habit.name
        
        progressView.setProgress(Float(daysCompleted / 21), animated: true)
        progressView.progressTintColor = habitIcon.tintColor
        progressView.trackTintColor = Keys.shared.background
    }
    
    // displays the number of days in the calendarView
    func habitLengthInDays() {
        guard let habit = self.habit,
            let startDateForHabit = habit.startDate as? Date else { return }
        for i in 0...20 {
            guard let daysBetween = calendar.date(byAdding: .day, value: i, to: startDateForHabit) else { return }
            habitDuration.append(daysBetween)
        }
    }
    
    // if the start date of your habit isn't a sunday, this will at the days before it from sunday
    func addDatesSinceSunday() {
        guard let startDate = habit?.startDate else { return }
        var sundayOnward: [Date] = []
        
        if isDateSunday(date: startDate as Date) {
            return
        } else {
            let dayComponent = dayComponentsSinceSunday(date: startDate as Date)
            let start = calendar.startOfDay(for: startDate as Date)
            for i in 1 ... dayComponent {
                guard let days = calendar.date(byAdding: .day, value: -i, to: start as Date) else { return }
                sundayOnward.append(days)
            }
        }
        for day in sundayOnward {
            habitDuration.insert(day, at: 0)
        }
    }
    
    
    //  MARK: - Properties
    
    var habit: Habit?
    
    var habitDuration = [Date]()
    
    let calendar = Calendar.current
    
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
    @IBOutlet var calendarHeader: UIView!
    @IBOutlet var monthLabel: UILabel!
    
    
}

// MARK: - Extension: UICollectionView

extension HabitDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return habitDuration.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calanderDate", for: indexPath) as? CalendarCollectionViewCell
        guard let habit = habit, let startDate = self.habit?.startDate else { return UICollectionViewCell() }
        
        guard let completionDays = habit.habitProgress?.array as? [DailyCompletion] else { return UICollectionViewCell() }
        
        let date = habitDuration[indexPath.row]
        let dayName = dayNameFormatter.string(from: date)
        let day = dayFormatter.string(from: date)
        cell?.dayName.text = dayName
        
        if date <= Date() {
            
            for completionDay in completionDays {
                if let completedDay = completionDay.completedDay as? Date {
                    if calendar.isDate(completedDay, inSameDayAs: date) {
                        cell?.dayButton.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 177/255, blue: 24/255, alpha: 1)
                    } else {
                        cell?.dayButton.backgroundColor = UIColor.red
                    }
                }
            }
        }
        
        if date < startDate as Date {
            
            cell?.dayButton.backgroundColor = UIColor.gray
            cell?.dayButton.alpha = 0.3
            cell?.dayName.alpha = 0.3
            
        } else if calendar.isDateInToday(date) {
            
            cell?.dayName.text = "\(dayName) (T)"
        } else if calendar.isDate(date, inSameDayAs: startDate as Date) {
            cell?.dayButton.backgroundColor = UIColor.yellow
            cell?.dayName.text = "\(dayName) (S)"
            
        }
        
        
        
        
        let currentMonth = calendar.dateComponents([.month], from: Date())
        
        
        
        
        cell?.date = date
        cell?.dayButton.setTitle(day, for: .normal)
        
        return cell ?? UICollectionViewCell()
    }
    
    // collectionview cell flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 7    // Number of items in a row
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 43)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
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
    
    func isDateSunday(date: Date) -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        if weekday == 1 {
            print("true")
            return true
        } else {
            print("false")
            return false
        }
    }
    
    func dayComponentsSinceSunday(date: Date) -> Int {
        var weekdayComponent = 0
        
        let weekday = calendar.component(.weekday, from: date)
        switch weekday {
        case 2:
            weekdayComponent = 1
        case 3:
            weekdayComponent = 2
        case 4:
            weekdayComponent = 3
        case 5:
            weekdayComponent = 4
        case 6:
            weekdayComponent = 5
        case 7:
            weekdayComponent = 6
        default:
            break
        }
        return weekdayComponent
    }
}















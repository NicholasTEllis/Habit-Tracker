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
import TwitterKit
import Fabric


class HabitDetailViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFacebookButton()
        setupTwitterButton()
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        updateWith()
        
        habitLengthInDays()
        addDatesSinceSunday()
        calendarCollectionView.center.x = self.view.center.x
        calendarCollectionView.frame.origin.y = monthLabel.frame.origin.y + monthLabel.frame.height
        
        iconStrikesStackView.frame.origin.y = (twitterButton.frame.origin.y + twitterButton.frame.height) + self.view.frame.height / 10
        streaksLabel.frame.origin.y = iconStrikesStackView.frame.origin.y + iconStrikesStackView.frame.height
        bestStreaksLabel.frame.origin.y = streaksLabel.frame.origin.y + streaksLabel.frame.height
    }
    
    
    //  MARK: - Main Methods
    
    func updateWith() {
        guard let habit = habit else { return }
        
        guard let icon = habit.icon,
            let colorKey = habit.color else { return }
        
        guard let currentStreak = habit.streaks.first,
            let bestStreak = habit.streaks.last else { return }
        
        habitIcon.image = UIImage(named: icon)
        self.habitIcon.backgroundColor = .clear
        habitIcon.tintColor = self.colorFrom(colorKey: colorKey)
        
        streaksLabel.text = "current streak: \(currentStreak)"
        bestStreaksLabel.text = "best streak: \(bestStreak)"
        
        let strikes = habit.strikes
        self.numberOfStrikes(from: strikes)
        
        monthLabel.text = monthFormatter.string(from: Date())
        self.title = habit.name
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
    
    // if the start date of your habit isn't a sunday, this will add the days before it from sunday
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
    
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        let composer = TWTRComposer()
        composer.setText("Forming newer and better habits with 21habit")
        composer.setImage(UIImage(named: "started"))
    
        // Called from a UIViewController
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var twitterButton: UIButton!

    @IBOutlet var habitIcon: UIImageView!
    @IBOutlet var strikeOne: UIImageView!
    @IBOutlet var strikeTwo: UIImageView!
    @IBOutlet var strikeThree: UIImageView!
    
    
    // calendar
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet var calendarHeader: UIView!
    @IBOutlet var monthLabel: UILabel!
    
    @IBOutlet var streaksLabel: UILabel!
    @IBOutlet var bestStreaksLabel: UILabel!
    
    @IBOutlet var iconStrikesStackView: UIStackView!
    
    
    
}


// MARK: - Extension: UICollectionView

extension HabitDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitDuration.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calanderDate", for: indexPath) as? CalendarCollectionViewCell, let habit = habit, let startDate = self.habit?.startDate, let daysCompleted = habit.habitProgress?.array as? [DailyCompletion] else { return UICollectionViewCell() }
        
        let date = habitDuration[indexPath.row]
        let dayName = dayNameFormatter.string(from: date)
        let day = dayFormatter.string(from: date)
        
        cell.dayName.text = dayName
        if date <= Date() {
            for dayCompleted in daysCompleted {
                if let completedDay = dayCompleted.completedDay as? Date {
                    let complete = calendar.startOfDay(for: completedDay)
                    let startOfDate = calendar.startOfDay(for: date)
                    
                    if calendar.isDate(complete, inSameDayAs: startOfDate) {
                        cell.dayButton.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 177/255, blue: 24/255, alpha: 1)
                        break
                    } else {
                        cell.dayButton.backgroundColor = UIColor.red
                    }
                }
            }
        }
        
        if date < startDate as Date {
            cell.dayButton.backgroundColor = UIColor.gray
            cell.dayButton.alpha = 0.3
            cell.dayName.alpha = 0.3
        }
        
        cell.dayName.text = dayName
        cell.date = date
        cell.dayButton.setTitle(day, for: .normal)
        
        return cell
    }
    
    
    // collectionview cell flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 7    // Number of items in a row
        let paddingSpace = sectionInsets.left * (itemsPerRow)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 49)
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
        let strikeColor = UIColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 1)
        switch strikes {
        case 0 :
            return
        case 1:
            strikeOne.tintColor = strikeColor
        case 2:
            strikeOne.tintColor = strikeColor
            strikeTwo.tintColor = strikeColor
        default:
            strikeOne.tintColor = strikeColor
            strikeTwo.tintColor = strikeColor
            strikeThree.tintColor = strikeColor
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
    
    func setupTwitterButton() {
        twitterButton.frame = CGRect(x: view.center.x - 150, y: view.center.y + 20, width: 143, height: 36)
        twitterButton.frame.origin.y = calendarCollectionView.frame.origin.y + calendarCollectionView.frame.height
    }
    
    func setupFacebookButton() {
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: "")
        content.contentTitle = "I started a new habit with 21habit"
        content.contentDescription = "Create better habits for yourself with 21habit. It's free on the app store!"
        content.imageURL = URL(string:"https://c1.staticflickr.com/1/746/33188446556_33c998f0a9_b.jpg")
        
        let facebookShare : FBSDKShareButton = FBSDKShareButton()
        facebookShare.shareContent = content
        facebookShare.frame = CGRect(x: view.center.x, y: view.center.y + 20, width: 143, height: 36) // move later
        facebookShare.frame.origin.y = calendarCollectionView.frame.origin.y + calendarCollectionView.frame.height
        self.view.addSubview(facebookShare)
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


/*
 Application Privacy Statement
 
 This privacy statement (“Privacy Statement”) applies to the treatment of personally identifiable information submitted by, or otherwise obtained from, you in connection with the associated application (“21habit”). By using or otherwise accessing the Application, you acknowledge that you accept the practices and policies outlined in this Privacy Statement.
 
WHAT PERSONAL INFORMATION DOES 21HABIT COLLECT?
 
 We collect the following types of information from our users:
 
 Personal Information You Provide to Us:
 We may receive and store any information you submit to the Application (or otherwise authorize us to obtain – such as, from (for example) your Facebook account or Twitter account). The types of personal information collected may include your full name, email address, gender, username, and any other information necessary for us to provide the Application services.
 
 
 21habit takes all measures reasonably necessary to protect User Personal Information from unauthorized access, alteration, or destruction; maintain data accuracy; and help ensure the appropriate use of User Personal Information. We follow generally accepted industry standards to protect the personal information submitted to us, both during transmission and once we receive it.
 
 
 
 WHAT PERSONAL INFORMATION CAN I ACCESS?
 
 21habit allows you to access the following information about you for the purpose of viewing, and in certain situations, updating that information. This list may change in the event the Application changes.
 
 - Account and user profile information
 - User e-mail address, if applicable
 - Facebook profile information, if applicable
 - User preferences
 - Application specific data
 
 
 CHANGES TO THIS PRIVACY STATEMENT.
 
 21habit may amend this Privacy Statement from time to time. Use of information we collect now is subject to the Privacy Statement in effect at the time such information is used. If we make changes in the way we use personal information, we will notify you by posting an announcement on our Site or sending you an email. Users are bound by any changes to the Privacy Statement when he or she uses or otherwise accesses the Application after such changes have been first posted.
 
 QUESTIONS OR CONCERNS.
 
 If you have any questions or concerns regarding privacy on our Website, please send us a detailed message at 21habitteam@gmail.com. We will make every effort to resolve your concerns.  */









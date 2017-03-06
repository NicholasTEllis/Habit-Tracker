//
//  HabitTableViewCell.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
   
    // MARK: - Outlets 
    
    @IBOutlet weak var habitIcon: UIImageView!
    @IBOutlet weak var strike1Image: UIImageView!
    @IBOutlet weak var strike2Image: UIImageView!
    @IBOutlet weak var strike3Image: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    

    var habit: Habit? {
        didSet {
            updateCell()
        }
    }
    
     //  MARK: - Setup Cell on tableview 
    
    func updateCell() {
        guard let habit = habit else { return }
        
        self.backgroundColor = Keys.shared.cellBackground
        
        self.habitNameLabel.text = habit.name
        self.habitNameLabel.textColor = Keys.shared.textColor
        
        guard let colorKey = habit.color else { return }
        let color = self.colorFrom(colorKey: colorKey)
        
        guard let habitIcon = habit.icon else { return }
        self.habitIcon.image = UIImage(named:habitIcon)
        self.habitIcon.backgroundColor = Keys.shared.cellBackground
        self.habitIcon.tintColor = color
        
        self.strike1Image.image = #imageLiteral(resourceName: "Strike")
        self.strike2Image.image = #imageLiteral(resourceName: "Strike")
        self.strike3Image.image = #imageLiteral(resourceName: "Strike")
        
        // TODO: - Fix this to count number of days completed, and days that have passed  
        
        guard let completedDays = habit.habitProgress?.count else { return }
        self.progressLabel.text = "\(completedDays)/21"
        self.progressLabel.textColor = Keys.shared.textColor
        
        self.progressBar.setProgress(Float(Float(completedDays) / 21), animated: true)
//        self.progressBar.progressTintColor = habit.iconColor
        self.progressBar.trackTintColor = Keys.shared.background
        
        // Count the number of strikes that the user has on the habit in the cell
        let strikes = strikeCounter(habit: habit)
        
        //  MARK: - Progress Functionalitiy
      
        
      //   change the color of the strike images to properly reflect the number of strikes
     //    TODO: - fix this to account for the current day's completion status
        switch strikes {
        case 1:
            strike1Image.tintColor = Keys.shared.iconColor5
        case 2:
            strike1Image.tintColor = Keys.shared.iconColor5
            strike2Image.tintColor = Keys.shared.iconColor5
        case 3:
            strike1Image.tintColor = Keys.shared.iconColor5
            strike2Image.tintColor = Keys.shared.iconColor5
            strike3Image.tintColor = Keys.shared.iconColor5
        default:
            return
        }
    }
    
    func strikeCounter(habit: Habit) -> Int {
        let calendar = NSCalendar.current
        guard let startDate = habit.startDate as? Date else {
            return 0 }
        
        let start = calendar.startOfDay(for: startDate)
        let current = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: start, to: current)
        guard let strikedDays = components.day else {
            return 0
        }
        return strikedDays
    }
}


 //  MARK: - Icon Colors 

extension HabitTableViewCell {
    
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
    
    
}

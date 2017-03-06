//
//  HabitTableViewCell.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import Social

class HabitTableViewCell: UITableViewCell {
   
    // MARK: - Outlets 
    
    @IBOutlet weak var habitIcon: UIImageView!
    @IBOutlet weak var strike1Image: UIImageView!
    @IBOutlet weak var strike2Image: UIImageView!
    @IBOutlet weak var strike3Image: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    

    var delegate: HabitTableViewCellDelegate?
    
    var habit: Habit? {
        didSet {
            updateCell()
        }
    }
    
     //  MARK: - Setup Cell on tableview 
    
    func updateCell() {
        guard let habit = habit else { return }
        
        self.backgroundColor = Keys.shared.background
        
        self.habitNameLabel.text = habit.name
        self.habitNameLabel.textColor = Keys.shared.textColor
        self.habitNameLabel.font = Keys.shared.font
        
        guard let colorKey = habit.color else { return }
        let color = Keys.shared.colorFrom(colorKey: colorKey)
        
        guard let habitIcon = habit.icon else { return }
        self.habitIcon.image = UIImage(named:habitIcon)
        self.habitIcon.backgroundColor = Keys.shared.background
        self.habitIcon.tintColor = color
        
        self.strike1Image.image = #imageLiteral(resourceName: "Strike")
        self.strike2Image.image = #imageLiteral(resourceName: "Strike")
        self.strike3Image.image = #imageLiteral(resourceName: "Strike")
        
        // TODO: - Fix this to count number of days completed, and days that have passed  
        
        guard let completedDays = habit.habitProgress?.count else { return }
        self.progressLabel.text = "\(completedDays)/21"
        self.progressLabel.textColor = Keys.shared.textColor
        
        //  MARK: - Progress Bar Functionalitiy
        self.progressBar.setProgress(Float(Float(completedDays) / 21), animated: true)
        self.progressBar.progressTintColor = color
        self.progressBar.trackTintColor = Keys.shared.background
        
        // Count the number of strikes that the user has on the habit in the cell
        let strikes = habit.strikes
      
        
      //   change the color of the strike images to properly reflect the number of strikes
     //    TODO: - fix this to account for the current day's completion status
        switch strikes {
        case 1:
            self.strike1Image.tintColor = UIColor.red
            self.strike2Image.tintColor = Keys.shared.darkGrayAccent
            self.strike3Image.tintColor = Keys.shared.darkGrayAccent
        case 2:
            self.strike1Image.tintColor = UIColor.red
            self.strike2Image.tintColor = UIColor.red
            self.strike3Image.tintColor = Keys.shared.darkGrayAccent
        case 3:
            self.strike1Image.tintColor = UIColor.red
            self.strike2Image.tintColor = UIColor.red
            self.strike3Image.tintColor = UIColor.red
        default:
            self.strike1Image.tintColor = Keys.shared.darkGrayAccent
            self.strike2Image.tintColor = Keys.shared.darkGrayAccent
            self.strike3Image.tintColor = Keys.shared.darkGrayAccent
        }
    }
}

protocol HabitTableViewCellDelegate {
    func presentTwitterController()
}


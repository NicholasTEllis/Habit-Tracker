//
//  HabitTableViewCell.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var habitIcon: UIImageView!
    @IBOutlet weak var strike1Image: UIImageView!
    @IBOutlet weak var strike2Image: UIImageView!
    @IBOutlet weak var strike3Image: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var habit: Habit? {
        didSet {
            updateCell()
        }
    }
    
    // setup what the cell will display
    func updateCell() {
        guard let habit = habit else { return }
        self.backgroundColor = Keys.shared.cellBackground
        self.habitNameLabel.text = habit.name
        self.habitNameLabel.textColor = Keys.shared.textColor
        guard let habitIcon = habit.icon else { return }
        self.habitIcon.image = UIImage(named:habitIcon)
        self.habitIcon.backgroundColor = Keys.shared.cellBackground
        self.strike1Image.image = #imageLiteral(resourceName: "Strike")
        self.strike2Image.image = #imageLiteral(resourceName: "Strike")
        self.strike3Image.image = #imageLiteral(resourceName: "Strike")
        
        // MARK: - This will probably break depending how we decide to add the daily isComplete object to the progress array.
        guard let completedDays = habit.habitProgress?.count else { return }
        self.progressLabel.text = "\(completedDays)/21"
        self.progressLabel.textColor = Keys.shared.textColor
        
        self.progressBar.setProgress(Float(completedDays / 21), animated: true)
        self.progressBar.progressTintColor = self.habitIcon.tintColor
        self.progressBar.trackTintColor = Keys.shared.background
        
        // Count the number of strikes that the user has on the habit in the cell
        var strikes = 0
        guard let progress = habit.habitProgress?.array as? [DailyCompletion] else { return }
        for day in progress {
            if day.isComplete == false {
                strikes += 1
            }
        }
        
        // change the color of the strike images to properly reflect the number of strikes
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
}

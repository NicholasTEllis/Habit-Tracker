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
        let habitIcon = UIImage(data: habit.icon as! Data)
        self.habitIcon.image = habitIcon
        self.strike1Image.image = #imageLiteral(resourceName: "Strike")
        self.strike2Image.image = #imageLiteral(resourceName: "Strike")
        self.strike3Image.image = #imageLiteral(resourceName: "Strike")
        
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
            strike1Image.tintColor = Keys.shared.iconRed
        case 2:
            strike1Image.tintColor = Keys.shared.iconRed
            strike2Image.tintColor = Keys.shared.iconRed
        case 3:
            strike1Image.tintColor = Keys.shared.iconRed
            strike2Image.tintColor = Keys.shared.iconRed
            strike3Image.tintColor = Keys.shared.iconRed
        default:
            return
        }
    }
}

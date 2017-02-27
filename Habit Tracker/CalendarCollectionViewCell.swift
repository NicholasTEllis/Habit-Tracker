//
//  CalendarCollectionViewCell.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/24/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    override func draw(_ rect: CGRect) {
        dayButton.layer.cornerRadius = 0.5 * dayButton.bounds.width
        
        guard let date = self.date else {
            return }
    }
    
    var startDate: Date?
    var date: Date?
    var completedDate: Date?
    
    let cal = Calendar.current
    

    @IBOutlet var dayName: UILabel!
    @IBOutlet var dayButton: UIButton!
}

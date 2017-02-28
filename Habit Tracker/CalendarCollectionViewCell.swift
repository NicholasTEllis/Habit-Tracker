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
        selectionView.layer.cornerRadius = 0.5 * selectionView.bounds.width
        selectionView.center.x = dayButton.center.x
        selectionView.center.y = dayButton.center.y
        
        
        guard let date = self.date else { return }
        
        if cal.isDate(date, inSameDayAs: today) {
            selectionView.backgroundColor = UIColor.black
        } else {
            selectionView.backgroundColor = .clear
        }
    }
    
    
    
    
    var date: Date?
    var today = Date()
    
    let cal = Calendar.current
    let dateComponents = DateComponents()

    @IBOutlet var dayName: UILabel!
    @IBOutlet var dayButton: UIButton!
    @IBOutlet var selectionView: UIView!
}

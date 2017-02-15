//
//  AddHabitViewController.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    var index: Int = 0
    
    
    func selectTime(index: Int) {
        switch index {
        case 0:
            timeOfDayLabel.text = "Indefinitely"
        case 1:
            timeOfDayLabel.text = "Morning"
        case 2:
            timeOfDayLabel.text = "Noon"
        case 3:
            timeOfDayLabel.text = "Evening"
        case 4:
            timeOfDayLabel.text = "Night"
        default:
            break
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet var habitNameTextField: UITextField!
    @IBOutlet var timeOfDayLabel: UILabel!
    @IBOutlet var timeDetailLabel: UILabel!
    
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftToDButtonTapped(_ sender: Any) {
        if(index >= 0 && index <= 4) {
            index -= 1
        }
    }
    
    @IBAction func rightToDButtonTapped(_ sender: Any) {
        
    }
    
}

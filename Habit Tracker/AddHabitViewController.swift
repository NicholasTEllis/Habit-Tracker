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
    }
    
    
}

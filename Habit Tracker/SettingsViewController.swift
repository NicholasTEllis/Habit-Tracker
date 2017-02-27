//
//  SettingsViewController.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    //  MARK: - Outlets
    
    @IBOutlet weak var morningFirstTextField: UITextField!
    @IBOutlet weak var afternoonFirstTextField: UITextField!
    @IBOutlet weak var eveningFirstTextField: UITextField!
    @IBOutlet weak var anyTextField: UITextField!
    
    static var morning = UserController.shared.user.morningTime
    static var afternoon = UserController.shared.user.afternoonTime
    static var evening = UserController.shared.user.eveningTime
    static var any = UserController.shared.user.anyTime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        
        morningFirstTextField.delegate = self
        morningFirstTextField.inputView = timePicker
        
        afternoonFirstTextField.delegate = self
        afternoonFirstTextField.inputView = timePicker
        
        eveningFirstTextField.delegate = self
        eveningFirstTextField.inputView = timePicker
        
        anyTextField.delegate = self
        anyTextField.inputView = timePicker
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Keyboard
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        textField.inputView = timePicker
        timePicker.addTarget(self, action: #selector(SettingsViewController.dateValueChanged), for: .valueChanged)
    }
    
    //  MARK: - Date
    
    func dateValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        if sender == morningFirstTextField.inputView {
            
            morningFirstTextField.text = formatter.string(from: sender.date)
            SettingsViewController.morning = sender.date as NSDate?
            AddHabitViewController.time = SettingsViewController.morning
            UserController.shared.updateUserTimes(withDate: sender.date as NSDate)
            
        } else if sender == afternoonFirstTextField.inputView {
            
            afternoonFirstTextField.text = formatter.string(from: sender.date)
            SettingsViewController.afternoon = sender.date as NSDate?
            UserController.shared.updateUserTimes(withDate: sender.date as NSDate)
            
        } else if sender == eveningFirstTextField.inputView {
            
            eveningFirstTextField.text = formatter.string(from: sender.date)
            SettingsViewController.evening = sender.date as NSDate?
            UserController.shared.updateUserTimes(withDate: sender.date as NSDate)
            
        } else if sender == anyTextField.inputView {
            
            anyTextField.text = formatter.string(from: sender.date)
            SettingsViewController.any = sender.date as NSDate
            UserController.shared.updateUserTimes(withDate: sender.date as NSDate)
        }
    }
    
    // ACTIONS:
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

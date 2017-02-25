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
    
    static var morning = ""
    static var afternoon = ""
    static var evening = ""
    static var any = ""
    
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
            guard let morningText = morningFirstTextField.text else {
                return
            }
            SettingsViewController.morning = morningText
            
        } else if sender == afternoonFirstTextField.inputView {
            afternoonFirstTextField.text = formatter.string(from: sender.date)
            guard let afternoonText = afternoonFirstTextField.text else {
                return
            }
            SettingsViewController.afternoon = afternoonText
            
        } else if sender == eveningFirstTextField.inputView {
            eveningFirstTextField.text = formatter.string(from: sender.date)
            guard let eveningText = eveningFirstTextField.text else {
                return
            }
            SettingsViewController.evening = eveningText
            
        } else if sender == anyTextField.inputView {
            anyTextField.text = formatter.string(from: sender.date)
            guard let anyText = anyTextField.text else {
                return
            }
            
            SettingsViewController.any = anyText
        }
    }
    
    func updateUserTimes() {
        let user = UserController.shared.user
        user.morningTime = SettingsViewController.morning
        user.afternoonTime = SettingsViewController.afternoon
        user.eveningTime = SettingsViewController.evening
        user.anyTime = SettingsViewController.any
    }
    
    // ACTIONS:

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        updateUserTimes()
        dismiss(animated: true, completion: nil)
    }
    
}

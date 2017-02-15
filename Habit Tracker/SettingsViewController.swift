//
//  SettingsViewController.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var morningFirstTextField: UITextField!
    @IBOutlet weak var morningSecondTextField: UITextField!
    
    @IBOutlet weak var afternoonFirstTextField: UITextField!
    @IBOutlet weak var afternoonSecondTextField: UITextField!
    
    @IBOutlet weak var eveningFirstTextField: UITextField!
    @IBOutlet weak var eveningSecondTextField: UITextField!
    
    var morningWindow: [String] = []
    var afternoonWindow: [String] = []
    var eveningWindow: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        
        morningFirstTextField.delegate = self
        morningSecondTextField.delegate = self
        morningFirstTextField.inputView = timePicker
        morningSecondTextField.inputView = timePicker
        
        afternoonFirstTextField.delegate = self
        afternoonSecondTextField.delegate = self
        afternoonFirstTextField.inputView = timePicker
        afternoonSecondTextField.inputView = timePicker
        
        eveningFirstTextField.delegate = self
        eveningSecondTextField.delegate = self
        eveningFirstTextField.inputView = timePicker
        eveningSecondTextField.inputView = timePicker
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        textField.inputView = timePicker
        timePicker.addTarget(self, action: #selector(SettingsViewController.dateValueChanged), for: .valueChanged)
    }
    
    func dateValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        if sender == morningFirstTextField.inputView {
            morningFirstTextField.text = formatter.string(from: sender.date)
            guard let morningFirst = morningFirstTextField.text else {
                return
            }
            morningWindow.append(morningFirst)
        } else if sender == morningSecondTextField.inputView {
            morningSecondTextField.text = formatter.string(from: sender.date)
            guard let morningSecond = morningSecondTextField.text else {
                return
            }
            morningWindow.append(morningSecond)
        } else if sender == afternoonFirstTextField.inputView {
            afternoonFirstTextField.text = formatter.string(from: sender.date)
            guard let afternoonFirst = afternoonFirstTextField.text else {
                return
            }
            afternoonWindow.append(afternoonFirst)
        } else if sender == afternoonSecondTextField.inputView {
            afternoonSecondTextField.text = formatter.string(from: sender.date)
            guard let afternoonSecond = afternoonSecondTextField.text else {
                return
            }
            afternoonWindow.append(afternoonSecond)
        } else if sender == eveningFirstTextField.inputView {
            eveningFirstTextField.text = formatter.string(from: sender.date)
            guard let eveningFirst = eveningFirstTextField.text else {
                return
            }
            eveningWindow.append(eveningFirst)
        } else if sender == eveningSecondTextField.inputView {
            eveningSecondTextField.text = formatter.string(from: sender.date)
            guard let eveningSecond = eveningSecondTextField.text else {
                return
            }
            eveningWindow.append(eveningSecond)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

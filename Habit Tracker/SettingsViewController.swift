//
//  SettingsViewController.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SettingsViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    //  MARK: - Outlets
    
    @IBOutlet weak var morningFirstTextField: UITextField!
    @IBOutlet weak var afternoonFirstTextField: UITextField!
    @IBOutlet weak var eveningFirstTextField: UITextField!
    @IBOutlet weak var anyTextField: UITextField!
    @IBOutlet weak var enableNotificationsButton: UIButton!
    @IBOutlet weak var faceBookLogout: UIButton!
    
    static var morning = TimeSettingsController.shared.morning
    static var afternoon = TimeSettingsController.shared.afternoon
    static var evening = TimeSettingsController.shared.evening
    static var any = TimeSettingsController.shared.anytime
    
    let loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //next three lines might be removed
        loginButton.delegate = self
        view.addSubview(loginButton)
        loginButtonConstraints()
        
        textFieldBorders()
        
        
        let navigationBarAppearance = UINavigationBar.appearance()
        guard let fontName = UIFont(name: "Avenir", size: 17) else { return }
        navigationBarAppearance.titleTextAttributes = [NSFontAttributeName: fontName]
        self.navigationController?.navigationBar.setBottomBorderColor(color: Keys.shared.iconColor1, height: 1)
        
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
        
        // set values to current user alert times
        morningFirstTextField.text = DateHelper.stringFromTimeInterval(interval: TimeSettingsController.shared.morning)
        afternoonFirstTextField.text = DateHelper.stringFromTimeInterval(interval: TimeSettingsController.shared.afternoon)
        eveningFirstTextField.text = DateHelper.stringFromTimeInterval(interval: TimeSettingsController.shared.evening)
        anyTextField.text = DateHelper.stringFromTimeInterval(interval: TimeSettingsController.shared.anytime)
    }
    
    //  MARK: - Facebook Constraints
    
    func loginButtonConstraints() {
        //idk if we need this google it
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
        
        guard let timeinterval = DateHelper.thisMorningAtMidnight else {
            return
        }
        
        if sender == morningFirstTextField.inputView {
            HabitController.shared.cancelLocalNotifications()
            morningFirstTextField.text = formatter.string(from: sender.date)
            let morning = sender.date.timeIntervalSince(timeinterval)
            TimeSettingsController.shared.morning = morning
        } else if sender == afternoonFirstTextField.inputView {
            afternoonFirstTextField.text = formatter.string(from: sender.date)
            let afternoon = sender.date.timeIntervalSince(timeinterval)
            TimeSettingsController.shared.afternoon = afternoon
        } else if sender == eveningFirstTextField.inputView {
            eveningFirstTextField.text = formatter.string(from: sender.date)
            let evening = sender.date.timeIntervalSince(timeinterval)
            TimeSettingsController.shared.evening = evening
        } else if sender == anyTextField.inputView {
            anyTextField.text = formatter.string(from: sender.date)
            let anyTime = sender.date.timeIntervalSince(timeinterval)
            TimeSettingsController.shared.anytime = anyTime
        }
    }
    
    // MARK: - Text Field Bottom Lines
    
    func textFieldBorders() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: morningFirstTextField.frame.height - 1, width: (morningFirstTextField.frame.width - 200), height: 1.0)
        bottomLine.backgroundColor = UIColor(colorLiteralRed: 3 / 255, green: 3 / 255, blue: 3 / 255, alpha: 0.5).cgColor
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: afternoonFirstTextField.frame.height - 1, width: (morningFirstTextField.frame.width - 200), height: 1.0)
        bottomLine2.backgroundColor = UIColor(colorLiteralRed: 3 / 255, green: 3 / 255, blue: 3 / 255, alpha: 0.5).cgColor
        let bottomLine3 = CALayer()
        bottomLine3.frame = CGRect(x: 0.0, y: eveningFirstTextField.frame.height - 1, width: (morningFirstTextField.frame.width - 200), height: 1.0)
        bottomLine3.backgroundColor = UIColor(colorLiteralRed: 3 / 255, green: 3 / 255, blue: 3 / 255, alpha: 0.5).cgColor
        
        let bottomLine4 = CALayer()
        bottomLine4.frame = CGRect(x: 0.0, y: anyTextField.frame.height - 1, width: (morningFirstTextField.frame.width - 200), height: 1.0)
        bottomLine4.backgroundColor = UIColor(colorLiteralRed: 3 / 255, green: 3 / 255, blue: 3 / 255, alpha: 0.5).cgColor
        morningFirstTextField.borderStyle = .none
        morningFirstTextField.layer.addSublayer(bottomLine)
        afternoonFirstTextField.borderStyle = .none
        afternoonFirstTextField.layer.addSublayer(bottomLine2)
        eveningFirstTextField.borderStyle = .none
        eveningFirstTextField.layer.addSublayer(bottomLine3)
        anyTextField.borderStyle = .none
        anyTextField.layer.addSublayer(bottomLine4)
    }
    
    // ACTIONS:
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let alertController = UIAlertController(title: "Logged out of Facebook", message: "You have been logged out of Facebook", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func enableNotificationsButtonTapped(_ sender: Any) {
        let alertController = UIAlertController (title: "Turn on notifications", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of Facebook.")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
    }
}

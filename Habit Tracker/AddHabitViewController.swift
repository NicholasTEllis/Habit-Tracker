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
        
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
        
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        swipeRight.addTarget(self, action: #selector(respondToSwipeGesture(_:)))

        
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        swipeLeft.addTarget(self, action: #selector(respondToSwipeGesture(_:)))
        
        iconCollectionView.backgroundColor = .clear
        iconCollectionView.allowsMultipleSelection = false
    }
    
    
    func respondToSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.left:
            indexIncreasing()
        case UISwipeGestureRecognizerDirection.right:
            indexDecreasing()
        default:
            return
        }
    }
    
    
    func selectTime(index: Int) {
        switch index {
        case 0:
            timeOfDayLabel.text = "Any"
        case 1:
            timeOfDayLabel.text = "Morning"
        case 2:
            timeOfDayLabel.text = "Afternoon"
        case 3:
            timeOfDayLabel.text = "Evening"
        default:
            return
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet var habitNameTextField: UITextField!
    @IBOutlet var timeOfDayLabel: UILabel!
    @IBOutlet var timeDetailLabel: UILabel!
    @IBOutlet var iconCollectionView: UICollectionView!
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = habitNameTextField.text,
            let timeOfNotification = timeOfDayLabel.text,
            let image = icon else { return }
        
        HabitController.shared.addHabit(name: name, imageName: image, startDate: NSDate(), timeOfNotification: timeOfNotification)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftToDButtonTapped(_ sender: Any) {
        indexDecreasing()
    }
    
    @IBAction func rightToDButtonTapped(_ sender: Any) {
        indexIncreasing()
    }
    
    
    // MARK: - Properties
    
    var index: Int = 0
    
    var icon: String?
    
    let imageIcon = Keys.shared.iconNames
    
}

// MARK: - Helper Methods

extension AddHabitViewController {
    
    func indexDecreasing() {
        if(index > 0 && index <= 4) {
            index -= 1
        }
        selectTime(index: index)
    }
    
    func indexIncreasing() {
        if(index >= 0 && index < 4) {
            index += 1
        }
        selectTime(index: index)
    }
}

// MARK: - Collection View Data Source 

extension AddHabitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageIcon.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as? IconsCollectionViewCell
        cell?.backgroundColor = UIColor.clear
        let icon = imageIcon[indexPath.row]
        cell?.iconImage.image = UIImage(named:icon)
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.cornerRadius = 5
        let icon = imageIcon[indexPath.row]
        self.icon = icon
       
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [], animations: {
            cell?.layer.backgroundColor = UIColor.white.cgColor
        }, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.35) { 
            cell?.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

}









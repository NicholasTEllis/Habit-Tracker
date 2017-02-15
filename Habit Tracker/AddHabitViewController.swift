//
//  AddHabitViewController.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconCollectionView.delegate = self
        
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        swipeRight.addTarget(self, action: #selector(respondToSwipeGesture(_:)))

        
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        swipeLeft.addTarget(self, action: #selector(respondToSwipeGesture(_:)))

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
    
    var icons: [UIImage] = []

    
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

extension AddHabitViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as UICollectionViewCell
        
        
        return cell
    }
}

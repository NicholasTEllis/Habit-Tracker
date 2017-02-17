//
//  ColorMenuView.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/17/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

class ColorMenuView: UIView {

    
    func select(index: Int) {
        
        
        switch index {
        case 0:
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.75,
                           options: .allowAnimatedContent,
                           animations: { self.selectionView.center.x = self.blackColorButtonOutlet.center.x }, completion: nil)
        case 1:
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.75,
                           options: .allowAnimatedContent,
                           animations: { self.selectionView.center.x = self.redColorButtonOutlet.center.x }, completion: nil)
        case 2:
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.75,
                           options: .allowAnimatedContent,
                           animations: { self.selectionView.center.x = self.greenColorButtonOutlet.center.x }, completion: nil)
        case 3:
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.75,
                           options: .allowAnimatedContent,
                           animations: { self.selectionView.center.x = self.purpleColorButtonOutlet.center.x }, completion: nil)
        case 4:
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.75,
                           options: .allowAnimatedContent,
                           animations: { self.selectionView.center.x = self.pinkColorButtonOutlet.center.x }, completion: nil)
        case 5:
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.75,
                           options: .allowAnimatedContent,
                           animations: { self.selectionView.center.x = self.yellowColorButtonOutlet.center.x }, completion: nil)
        default:
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.75,
                           options: .allowAnimatedContent,
                           animations: { self.selectionView.center.x = self.orangeColorButtonOutlet.center.x }, completion: nil)
        }
    }
  
    
    
    
    // MARK: - Outlet
    
    @IBOutlet var blackColorButtonOutlet: UIButton!
    @IBOutlet var redColorButtonOutlet: UIButton!
    @IBOutlet var greenColorButtonOutlet: UIButton!
    @IBOutlet var purpleColorButtonOutlet: UIButton!
    @IBOutlet var pinkColorButtonOutlet: UIButton!
    @IBOutlet var yellowColorButtonOutlet: UIButton!
    @IBOutlet var orangeColorButtonOutlet: UIButton!
    
    @IBOutlet var selectionView: UIView!
    
    
    // MARK: - Actions
    @IBAction func colorButtonTapped(_ sender: UIButton) {
    }
    
   
}


//MARK: - EXTENSION: Helper Methods

extension ColorMenuView {
    
    func circularButtons(buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 0.5 * button.layer.bounds.width
        }
    }
    
}

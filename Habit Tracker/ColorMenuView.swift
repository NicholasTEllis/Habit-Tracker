//
//  ColorMenuView.swift
//  Habit Tracker
//
//  Created by Ilias Basha on 2/17/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit

protocol ColorMenuDelegate: class {
    func colorMenuButtonTapped(at index: Int, with color: UIColor)
}

class ColorMenuView: UIView {
    
    // MARK: -  Internal Properties
    
    var colorKey: String = "iconColor1"
    
    weak var delegate: ColorMenuDelegate?
    
     //  MARK: - Color Button
    
    override func draw(_ rect: CGRect) {
        self.circularButtons(buttons: [blackColorButtonOutlet,
                                       redColorButtonOutlet,
                                       greenColorButtonOutlet,
                                       purpleColorButtonOutlet,
                                       pinkColorButtonOutlet,
                                       yellowColorButtonOutlet,
                                       orangeColorButtonOutlet])
        
        selectionView.frame = CGRect(x: -40, y: 43, width: 35, height: 3)
        selectionView.layer.cornerRadius = 5
        selectionView.center.x = blackColorButtonOutlet.center.x
        selectionView.center.y = blackColorButtonOutlet.center.y + 20
        selectionView.alpha = 0
    }
    
    
    func select(index: Int) {
        
        switch index {
        case 0:
            selectColor(button: blackColorButtonOutlet)
            self.colorKey = "iconColor1"
        case 1:
            selectColor(button: redColorButtonOutlet)
            self.colorKey = "iconColor2"
        case 2:
            selectColor(button: greenColorButtonOutlet)
            self.colorKey = "iconColor3"
        case 3:
            selectColor(button: purpleColorButtonOutlet)
             self.colorKey = "iconColor4"
        case 4:
            selectColor(button: pinkColorButtonOutlet)
            self.colorKey = "iconColor5"
        case 5:
            selectColor(button: yellowColorButtonOutlet)
            self.colorKey = "iconColor6"
        default:
            selectColor(button: orangeColorButtonOutlet)
            self.colorKey = "iconColor7"
            
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
        guard let color: UIColor = sender.backgroundColor else { return }
        delegate?.colorMenuButtonTapped(at: sender.tag, with: color)
    }
}


//MARK: - EXTENSION: Helper Methods

extension ColorMenuView {
    
    func circularButtons(buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 0.5 * button.bounds.width
        }
    }
    
    
    func selectColor(button: UIButton) {
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.9,
                       options: .allowAnimatedContent,
                       animations: {
                        self.selectionView.backgroundColor = button.backgroundColor
                        self.selectionView.center.x = button.center.x
                        self.selectionView.center.y = button.center.y + 20
                        self.selectionView.alpha = 1
        },
                       completion: nil)
    }
    
    
    func setColorKey() -> String {
        return self.colorKey
    }
    
}

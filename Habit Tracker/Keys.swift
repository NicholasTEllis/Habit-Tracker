//
//  Keys.swift
//  Habit Tracker
//
//  Created by Keaton Harward on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import Foundation
import UIKit

class Keys {
    
    static let shared = Keys()
    
    var fireTimesDictionary: [String : Double] = ["morning": 1500.0,"afternoon" :3000.0,"evening" :4500.0,"anytime" :6000.0]
    
    // black
    let iconColor1 = UIColor(colorLiteralRed: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
    // salmon-ey
    let iconColor2 = UIColor(colorLiteralRed: 255 / 255, green: 97 / 255, blue: 94 / 255, alpha: 1)
    // green
    let iconColor3 = UIColor(colorLiteralRed: 89 / 255, green: 255 / 255, blue: 158 / 255, alpha: 1)
    // lilac
    let iconColor4 = UIColor(colorLiteralRed: 152 / 255, green: 145 / 255, blue: 255 / 255, alpha: 1)
    // pink
    let iconColor5 = UIColor(colorLiteralRed: 255 / 255, green: 145 / 255, blue: 223 / 255, alpha: 1)
    // yeller
    let iconColor6 = UIColor(colorLiteralRed: 255 / 255, green: 219 / 255, blue: 143 / 255, alpha: 1)
    // naranja
    let iconColor7 = UIColor(colorLiteralRed: 255 / 255, green: 156 / 255, blue: 105 / 255, alpha: 1)
    
    func colorFrom(colorKey: String) -> UIColor {
        switch colorKey {
        case "iconColor1":
            return Keys.shared.iconColor1
        case "iconColor2" :
            return Keys.shared.iconColor2
        case "iconColor3" :
            return Keys.shared.iconColor3
        case "iconColor4" :
            return Keys.shared.iconColor4
        case "iconColor5" :
            return Keys.shared.iconColor5
        case "iconColor6" :
            return Keys.shared.iconColor6
        default:
            return Keys.shared.iconColor7
        }
    }

    // Pick a color any color
    // let icon8 = UIColor(colorLiteralRed: <#T##Float#>, green: <#T##Float#>, blue: <#T##Float#>, alpha: <#T##Float#>)
    // let icon9 = UIColor(colorLiteralRed: <#T##Float#>, green: <#T##Float#>, blue: <#T##Float#>, alpha: <#T##Float#>)
    
    // VVV Let's pick these here now
    let alternateBackground = UIColor(colorLiteralRed: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1)
    let background = UIColor(colorLiteralRed: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
    let darkGrayAccent = UIColor(colorLiteralRed: 200 / 255, green: 199 / 255, blue: 204 / 255, alpha: 1)
    
    let primaryAccent = UIColor.cyan
    
    // textStyle? celltextStyle?
    let textColor = UIColor(colorLiteralRed: 3 / 255, green: 3 / 255, blue: 3 / 255, alpha: 1)
    let font = UIFont(name: "Avenir", size: 17)
    
    // Strings and such
    
    let swipeToCompleteString = "Complete Habit"
    let swipeToUndoCompletion = "I didn't do that yet!"
    
    
    let iconNames = ["app window", "audio mixer", "bomb", "book", "briefcase", "chaplin", "bullseye", "chef hat", "clock", "coffee machine", "cooking pot", "crop circle", "cycle", "desktop 1", "desktop 2", "desktop 3", "download book", "edit", "envelope", "fountain pen 1", "fountain pen 2", "fountain pen", "globe", "grill", "hashhashtag", "headphones", "heart speach", "heart", "hot dog", "house", "ipad", "iphone", "ipod", "laptop 1", "laptop 2", "layers", "lazy boy", "link chain", "locked", "luggage", "magic wand", "magnet", "marker", "martini", "microphone", "note", "paint pallete", "paint roller", "paintbrush", "person speaking", "person", "photo", "pin", "pooring bucket", "popsicle", "quil", "robot", "scroll", "settings", "shield cross", "shopping cart", "silverware", "skull", "smiley", "speach bubble", "speedometer", "stamp", "syringe", "teapot", "trash can", "tv", "umbrella", "unlocked", "video camera", "wrench x"]
}

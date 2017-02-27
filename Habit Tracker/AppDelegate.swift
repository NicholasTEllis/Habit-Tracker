//
//  AppDelegate.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/14/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import UserNotifications
import FBSDKCoreKit
import Firebase
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //  MARK: - App Delegate Did Finish Launching & Facebook/Twitter

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController = storyBoard.instantiateViewController(withIdentifier: "Onboarding")
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "onboardingComplete"){
            initialViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
            
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
        Fabric.with([Twitter.self])
        
        FIRApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        
        // Compare last launch date and reset completion properties if necessary
        let lastLaunch = UserDefaults.standard.double(forKey: "lastLaunch")
        if lastLaunch == 0 {
            // Create user if the application has not ever been launched before
            
            // TODO: - Check with Keaton if this is the right function
            
            UserController.shared.createUserTime(morningTime: NSDate(), afternoonTime: NSDate(), eveningTime: NSDate(), anyTime: NSDate())
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "lastLaunch")
        } else {
        let lastLaunchDate = Date(timeIntervalSince1970: lastLaunch)
        let lastLaunchIsToday = NSCalendar.current.isDateInToday(lastLaunchDate)
        if !lastLaunchIsToday {
            DailyCompletionController.shared.endOfDayCompletions()
        }
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "lastLaunch")
        print("This is your launchdate: \(lastLaunchDate)")
        }
        return true
    }
    
     //  MARK: - App Delegate Facebook
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if ((FBSDKAccessToken.current()) != nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "customTabBar")
            self.window?.rootViewController = viewController
            print("user is logged in")

        }else{
            print("user is not logged in, and it means sohail gives very sensual hugs")
        }
    }
}

 //  MARK: - To settings app 

extension UIApplication {
    class func openAppSettings() {
        guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
}


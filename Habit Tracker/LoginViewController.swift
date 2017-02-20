//
//  LoginViewController.swift
//  Habit Tracker
//
//  Created by zeus on 2/19/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseCore
import FirebaseAuth
import TwitterKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTwitterButton()
        
        let loginButton = FBSDKLoginButton()
        
        self.view.backgroundColor = .gray
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 250, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
    }
    
    func setupTwitterButton() {
        let twitterButton = TWTRLogInButton { (session, error) in
            if let err = error {
                print("Failed to log in to Twitter.", err)
            }
            print("Successfully logged into Twitter.")
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
        }
        view.addSubview(twitterButton)
        twitterButton.frame = CGRect(x: 16, y: 250 + 66, width: view.frame.width - 32, height: 50)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of Facebook.")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
        performSegue(withIdentifier: "toHomeScreen", sender: self)
    }
    
    
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            print("Successfully logged in with user: ", user ?? "")
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name , email"]).start { (connection, result, error) in
            if error != nil {
                print("Failed to start graph request:", error ?? "")
                return
            }
            print(result ?? "")
        }
    }
    
    
}

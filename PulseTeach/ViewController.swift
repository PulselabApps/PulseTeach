//
//  ViewController.swift
//  PulseTeach
//
//  Created by Max Marze on 12/22/15.
//  Copyright © 2015 Pulse Lab. All rights reserved.
//

import UIKit
import Bolts
import Parse
import ParseUI

class ViewController: UIViewController , PFLogInViewControllerDelegate {

    var isLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        let logInController = PFLogInViewController()
        logInController.delegate = self
        logInController.fields = [.UsernameAndPassword, .LogInButton]
        self.presentViewController(logInController, animated: true, completion: nil)
        
//        if !isLoggedIn {
//            if let _ = PFUser.currentUser() {
//                isLoggedIn = true
//            } else {
//                let logInController = PFLogInViewController()
//                logInController.delegate = self
//                logInController.fields = [.UsernameAndPassword, .LogInButton]
//                self.presentViewController(logInController, animated: true, completion: nil)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK -: PFLogInViewControllerDelegate
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        let requestParams = ["username": username]
        
        do {
            _ = try PFCloud.callFunction("isTeacher", withParameters: requestParams)
            print("All Good")
            return true
        } catch(_) {
            print("error")
            return false
        }
        
        
//        return true
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        print(user.username!)

//        let roleACL = PFACL()
//        roleACL.publicReadAccess = true
//        let role = PFRole(name: "Teacher", acl: roleACL)
//        role.users.addObject(user)
//        role.saveInBackgroundWithBlock { (success, error) -> Void in
//            if error == nil && success {
//                print("Blarg")
//            }
//        }
        
        ClassCollectionModel.sharedInstance.initializeClassesTaught { () -> Void in
            self.dismissViewControllerAnimated(true) { () -> Void in
                self.isLoggedIn = true
            }
        }
    }


}


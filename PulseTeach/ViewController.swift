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
        if !isLoggedIn {
            if let _ = PFUser.currentUser() {
                isLoggedIn = true
            } else {
                let logInController = PFLogInViewController()
                logInController.delegate = self
                logInController.fields = [.UsernameAndPassword, .LogInButton]
                self.presentViewController(logInController, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK -: PFLogInViewControllerDelegate
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        return true
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        print(user.username!)
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.isLoggedIn = true
        }
    }


}


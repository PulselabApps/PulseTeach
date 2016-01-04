//
//  SplitContainerViewController.swift
//  PulseTeach
//
//  Created by Max Marze on 1/3/16.
//  Copyright © 2016 Pulse Lab. All rights reserved.
//

import UIKit

class SplitContainerViewController: UIViewController {

    var currentSession : ClassSession_Beta!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "splitEmbedOne" {
            if let splitVC = segue.destinationViewController as? UISplitViewController {
                if let splitNavVC = splitVC.viewControllers.first as? UINavigationController {
                    if let questionTableVC = splitNavVC.topViewController as? QuestionsQueryTableViewController {
                        questionTableVC.currentSession = self.currentSession
                        if let detailVC = splitVC.viewControllers.last as? QuestionDetailViewController {
                            questionTableVC.delegate = detailVC
                        }
                        splitVC.preferredDisplayMode = .AllVisible
                    }
                }
            }
        }
    }
    

}

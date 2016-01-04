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
        
//        self.navigationItem.title = String(currentSession.createdAt!)
        self.navigationItem.title = "Question Detail"
        
        let navbutton = UIBarButtonItem(title: "Add Question", style: .Plain, target: self, action: "addQuestion:")
        self.navigationItem.rightBarButtonItem = navbutton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addQuestion(sender : AnyObject?) {
        print("Blah")
        self.performSegueWithIdentifier("addQuestionSegue", sender: nil)
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
        } else if segue.identifier == "addQuestionSegue" {
            if let destVC = segue.destinationViewController as? AddQuestionFormViewController {
                destVC.currentClassSession = self.currentSession
            }
        }
    }
    

}

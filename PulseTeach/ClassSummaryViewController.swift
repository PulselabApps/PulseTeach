//
//  ClassSummaryViewController.swift
//  PulseTeach
//
//  Created by Max Marze on 12/29/15.
//  Copyright © 2015 Pulse Lab. All rights reserved.
//

import UIKit

class ClassSummaryViewController: UIViewController {

    @IBOutlet var addQuestionButton: UIButton!
    
    
    var currentClass : PulseClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorConstants.GrayNormalButtonColor
        // Do any additional setup after loading the view.
        self.navigationItem.title = currentClass.name
        
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
        if segue.identifier == "addQuestionSegue" {
            if let destVC = segue.destinationViewController as? UINavigationController {
                if let addQuestionVC = destVC.topViewController as? AddQuestionFormViewController {
                    print("Blargh question")
                    addQuestionVC.currentClass = currentClass
                }
                
            }
        } else if segue.identifier == "tableEmbed" {
            if let destVC = segue.destinationViewController as? ClassSessionsTableViewController {
                destVC.currentClass = self.currentClass
            }
        }
    }
    

}

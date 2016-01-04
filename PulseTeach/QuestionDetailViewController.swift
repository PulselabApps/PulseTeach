//
//  QuestionDetailViewController.swift
//  PulseTeach
//
//  Created by Max Marze on 1/3/16.
//  Copyright © 2016 Pulse Lab. All rights reserved.
//

import UIKit
import Bolts
import Parse

class QuestionDetailViewController: UIViewController, QuestionDetailDelegate {

    @IBOutlet var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func questionSelected(question : PFObject) {
        let text = question["text"] as! String
        
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .ByWordWrapping
        textLabel.text = text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

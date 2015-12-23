//
//  AddQuestionFormViewController.swift
//  PulseTeach
//
//  Created by Max Marze on 12/22/15.
//  Copyright © 2015 Pulse Lab. All rights reserved.
//

import UIKit
import Eureka

class AddQuestionFormViewController: FormViewController {

    var answerNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Question Type")
        
            <<< PickerRow<String>("Question Type") { (row : PickerRow<String>) -> Void in
                row.options = ["Fill in The Blank", "Multiple Choice"]
                
            }
        
            +++ Section("Question Text") {
                $0.tag = "questionText"
            }
        
            <<< TextAreaRow() {
                $0.title = "Question Text"
                $0.placeholder = "Question?"
            }
        
            +++ Section("Answers")
            
            <<< ButtonRow() {
                $0.title = "Button"
                $0.tag = "addAnswer"
                $0.onCellSelection({ (cell, row) -> () in
                    print("Clicked Row Button")
                    let x = TextRow() {
                        $0.title = "Answer Choice"
                        $0.tag = "choice\(self.answerNumber)"
                        $0.placeholder = "Answer"
                    }
                    self.answerNumber++
                    row.section!.insert(x, atIndex: row.indexPath()!.row)
                })
            }
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func submitButtonAction(sender: AnyObject) {
        print("Submit button")
        let x = self.form.values()
        print("x")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

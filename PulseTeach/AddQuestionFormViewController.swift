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
    
    var currentClass : PulseClass!
    
    var currentClassSession : ClassSession_Beta!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = ClassSession_Beta.query()!
        query.orderByDescending("updatedAt")
        query.whereKey("classIn", equalTo: self.currentClass)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                if let session = object as? ClassSession_Beta {
                    self.currentClassSession = session
                    print("Found Session")
                }
            }
        }
        
        form +++ Section("Question Type")
        
            <<< PickerRow<String>("Question Type") { (row : PickerRow<String>) -> Void in
                row.options = ["Fill in The Blank", "Multiple Choice"]
                
            }
        
            +++ Section("Question Text") {
                $0.tag = "questionText"
            }
        
            <<< TextAreaRow() {
                $0.title = "Question Text"
                $0.tag = "questionTextArea"
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
//    @NSManaged var questionType : Int
//    @NSManaged var text : String
//    @NSManaged var time : Int
//    @NSManaged var numCorrectAn/swers : Int
//    @NSManaged var numIncorrectAnswers : Int
//    @NSManaged var answers : [String]
//    @NSManaged var answerBreakdown : [String : Int]
    @IBAction func submitButtonAction(sender: AnyObject) {
        print("Submit button")
        let x = self.form.values()
        let questionType = x["Question Type"] as! String
        var answers = [String]()
        var answerBreakdown = [String : Int]()
        let text = x ["questionTextArea"] as! String
        for i in 0..<self.answerNumber {
            let answer = x["choice\(i)"] as! String
            answers.append(answer)
            answerBreakdown[answer] = 0
        }
        
        let newQuestion = Question()
        newQuestion.answerBreakdown = answerBreakdown
        newQuestion.text = text
        newQuestion.answers = answers
        newQuestion.questionType = QuestionType.determineTypeFromString(questionType)!.rawValue
        newQuestion.numCorrectAnswers = 0
        newQuestion.numIncorrectAnswers = 0
        
        newQuestion.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil && success {
                self.currentClassSession.questions.addObject(newQuestion)
                self.currentClassSession.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if error == nil && success {
                        print("Successfully added a question")
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                })
            }
        }
        
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

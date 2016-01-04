//
//  QuestionsQueryTableViewController.swift
//  PulseTeach
//
//  Created by Max Marze on 1/3/16.
//  Copyright © 2016 Pulse Lab. All rights reserved.
//

import UIKit
import Bolts
import Parse
import ParseUI

class QuestionsQueryTableViewController: PFQueryTableViewController {

    var currentSession : ClassSession_Beta!
    var sections = [String : [PFObject]]()
    var sectionKeys = [String]()
    
    weak var delegate : QuestionDetailDelegate?
    
    override func queryForTable() -> PFQuery {
        let questionRelation = currentSession.relationForKey("questions")
        let query = questionRelation.query()
        
        return query
    }
    
    override func objectsDidLoad(error: NSError?) {
        super.objectsDidLoad(error)
        if error == nil {
            if let objects = self.objects as? [PFObject] {
                self.sections.removeAll(keepCapacity: false)
                self.sectionKeys.removeAll(keepCapacity: false)
                for object in objects {
                    let type = object["questionType"] as! Int
                    if let trueType = QuestionType(rawValue: type) {
                        if let sectionSTring = trueType.typeName() {
                            var array = self.sections[sectionSTring] ?? Array()
                            array.append(object)
                            self.sections[sectionSTring] = array
                        }
                    }
                }
                self.sectionKeys = Array(self.sections.keys).sort()
                self.tableView.reloadData()
            }
//            if let questions = self.objects as? [Question] {
//                for question in questions {
//                    let type = question.questionType
//                    if let trueType = QuestionType(rawValue: type) {
//                        if let sectionString = trueType.typeName() {
//                            var array = self.sections[sectionString] ?? Array()
//                            array.append(question)
//                            self.sections[sectionString] = array
//                        }
//                    }
//                }
//                self.sectionKeys = Array(self.sections.keys).sort()
//            }
        }
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath?) -> PFObject? {
        if let indexPath = indexPath {
            let array = self.sections[self.sectionKeys[indexPath.section]]
            return array?[indexPath.row]
        } else {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionKeys.count 
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = self.sections[self.sectionKeys[section]]
        return array?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = self.sectionKeys[section]
        return title
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let identifier = "questionQueryCell"
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as? PFTableViewCell
        
        if cell == nil {
            cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        
        var title = ""
        if let question = object {
            title = question["text"] as! String
        }
        
        cell!.textLabel!.text = title
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.questionSelected(objectAtIndexPath(indexPath)!)
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

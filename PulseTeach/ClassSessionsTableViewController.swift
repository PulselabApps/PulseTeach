//
//  ClassSessionsTableViewController.swift
//  PulseTeach
//
//  Created by Max Marze on 1/2/16.
//  Copyright © 2016 Pulse Lab. All rights reserved.
//

import UIKit
import Bolts
import Parse
import ParseUI

class ClassSessionsTableViewController: PFQueryTableViewController {

    var sections = [String : [PFObject]]()
    var sectionKeys = [String]()
    
    var currentClass : PulseClass!
    
    override func queryForTable() -> PFQuery {
        
        let query = ClassSession_Beta.query()!
        query.whereKey("classIn", equalTo: self.currentClass)
        return query
    }
    
    override func objectsDidLoad(error: NSError?) {
        super.objectsDidLoad(error)
        if error == nil {
            self.sections.removeAll(keepCapacity: false)
            self.sectionKeys.removeAll(keepCapacity: false)
            if let objects = self.objects as? [PFObject] {
                for object in objects {
                    var array = self.sections["Sessions"] ?? Array()
                    array.append(object)
                    sections["Sessions"] = array
                }
            }
            
            sectionKeys = Array(sections.keys).sort()
            self.tableView.reloadData()
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
        let identifier = "sessionResuseCell"
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as? PFTableViewCell
        
        if cell == nil {
            cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        
        var title = ""
        if let object = object as? ClassSession_Beta {
            title = String(object.createdAt!)
        }
        
        cell!.textLabel!.text = title
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let sb = self.storyboard {
            let vc = sb.instantiateViewControllerWithIdentifier("splitEmbedVC")
            if let newVC = vc as? SplitContainerViewController {
                newVC.currentSession = self.objectAtIndexPath(indexPath) as! ClassSession_Beta
                self.navigationController!.pushViewController(newVC, animated: true)
            }
        }
//        if let sb = self.storyboard {
//            let vc = sb.instantiateViewControllerWithIdentifier("sessionSplitSummary")
//            if let splitVC = vc as? UISplitViewController {
//                
//                
//                if let splitNavVC = splitVC.viewControllers.first as? UINavigationController {
//                    if let questionTableVC = splitNavVC.topViewController as? QuestionsQueryTableViewController {
//                        questionTableVC.currentSession = self.objectAtIndexPath(indexPath) as! ClassSession_Beta
//                        splitVC.preferredDisplayMode = .AllVisible
//                    }
//                }
////                self.navigationController!.pushViewController(splitVC, animated: true)
//                
////                self.presentViewController(splitVC, animated: true, completion: { () -> Void in
////                    print("Presented SPlit")
////                })
//            }
//            
//        }
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

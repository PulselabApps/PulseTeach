//
//  ClassCollectionModel.swift
//  PulseTeach
//
//  Created by Max Marze on 12/28/15.
//  Copyright © 2015 Pulse Lab. All rights reserved.
//

import Foundation
import Bolts
import Parse

class ClassCollectionModel {
    static let sharedInstance = ClassCollectionModel()
    
    private var classes = [PulseClass]()
    
    private init() {
        
    }
    
    func initializeClassesTaught(completion : () -> Void) {
        
        if let user = PFUser.currentUser() {
            if let query = PulseClass.query() {
                query.whereKey("teacher", equalTo: user)
                query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                    if error == nil {
                        if let classes = objects as? [PulseClass] {
                            self.classes = classes
                            completion()
                        }
                    }
                })
            }
        }
    
    }
    
    func classAtIndex(index : NSIndexPath) -> PulseClass {
        return classes[index.row]
    }
    
    func numberOfClasses() -> Int {
        return classes.count
    }
}
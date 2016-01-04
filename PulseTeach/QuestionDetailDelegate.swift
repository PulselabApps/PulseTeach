//
//  QuestionDetailDelegate.swift
//  PulseTeach
//
//  Created by Max Marze on 1/3/16.
//  Copyright © 2016 Pulse Lab. All rights reserved.
//

import Foundation
import Bolts
import Parse

protocol QuestionDetailDelegate : class {
    func questionSelected(question : PFObject)
}
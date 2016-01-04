//
//  Question.swift
//  PulsetvOS
//
//  Created by Max Marze on 11/12/15.
//  Copyright © 2015 pulse. All rights reserved.
//
import Bolts
import Parse

enum QuestionType : Int {
    case MultipleChoice
    case FillInTheBlank
}

extension QuestionType {
    static func determineTypeFromString(x : String) -> QuestionType? {
        switch x {
            case "Multiple Choice":
                return .MultipleChoice
            case "Fill in The Blank":
                return .FillInTheBlank
        default:
            return nil
        }
    }
    
    func typeName() -> String? {
        switch self {
        case .MultipleChoice:
            return "Multiple Choice"
        case .FillInTheBlank:
            return "Fill in The Blank"
        default:
            return nil
        }
    }
}

class Question: PFObject, PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Question"
    }
    
    @NSManaged var questionType : Int
    @NSManaged var text : String
    @NSManaged var time : Int
    @NSManaged var numCorrectAnswers : Int
    @NSManaged var numIncorrectAnswers : Int
    @NSManaged var answers : [String]
    @NSManaged var answerBreakdown : [String : Int]
}
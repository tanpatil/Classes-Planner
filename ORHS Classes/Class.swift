//
//  Class.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/4/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import Foundation
import os.log


class Class: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var subject: String
    var credits: String
    var GPA: String
    var hours: String
    var summary: String
    var added: Bool
    var grade: Int
    var percent: String
    //MARK: Initilizer
    init?(data: [String], added: Bool, grade:Int) {
        
        if data.isEmpty {
            print("missing class data")
            return nil
        }
        self.name = data[0]
        self.subject = data[1]
        
        self.credits = data[2]
        self.GPA = data[3]
        self.hours = data[4]
        self.summary = data[5]
        self.added = added
        self.grade = grade
        self.percent = data[6]
    }
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let subject = "subject"
        static let credits = "credits"
        static let GPA = "GPA"
        static let hours = "hours"
        static let summary = "summary"
        static let added = "added"
        static let grade = "grade"
        static let percent = "percent"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(subject, forKey: PropertyKey.subject)
        aCoder.encode(credits, forKey: PropertyKey.credits)
        aCoder.encode(GPA, forKey: PropertyKey.GPA)
        aCoder.encode(hours, forKey: PropertyKey.hours)
        aCoder.encode(summary, forKey: PropertyKey.summary)
        aCoder.encode(added, forKey: PropertyKey.added)
        aCoder.encode(grade, forKey: PropertyKey.grade)
        aCoder.encode(percent, forKey: PropertyKey.percent)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else{
            os_log("Unable to decode the name for a Class object.", log: OSLog.default, type: .debug)
            return nil
        }
        let subject = aDecoder.decodeObject(forKey: PropertyKey.subject) as! String
        let credits = aDecoder.decodeObject(forKey: PropertyKey.credits) as! String
        let GPA = aDecoder.decodeObject(forKey: PropertyKey.GPA) as! String
        let hours = aDecoder.decodeObject(forKey: PropertyKey.hours) as! String
        let summary = aDecoder.decodeObject(forKey: PropertyKey.summary) as! String
        let added = aDecoder.decodeBool(forKey: PropertyKey.added)
        let grade = aDecoder.decodeInteger(forKey: PropertyKey.grade)
        let percent = aDecoder.decodeObject(forKey: PropertyKey.percent) as! String
        self.init(data: [name, subject, credits, GPA, hours, summary, percent], added: added, grade: grade)
    }
    
}

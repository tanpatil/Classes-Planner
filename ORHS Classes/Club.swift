//
//  Club.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/3/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import Foundation
import os.log
class Club: NSObject, NSCoding {

    //MARK: Properties
    var name: String
    var days: String
    var times: String
    var commitment: String
    var link: String //make link
    var summary: String
    var add: Bool

    //MARK: Initilizer
    init?(data: [String], add: Bool) {
        if data.isEmpty {
            print("missing club data")
            return nil
        }
        self.name = data[0]
        self.days = data[1]
        self.times = data[2]
        self.commitment = data[3]
        self.link = data[4]
        self.summary = data[5]
        self.add = add
    }
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let days = "days"
        static let times = "times"
        static let commitment = "commitment"
        static let link = "link"
        static let summary = "summary"
        static let add = "add"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(days, forKey: PropertyKey.days)
        aCoder.encode(times, forKey: PropertyKey.times)
        aCoder.encode(commitment, forKey: PropertyKey.commitment)
        aCoder.encode(link, forKey: PropertyKey.link)
        aCoder.encode(summary, forKey: PropertyKey.summary)
        aCoder.encode(add, forKey: PropertyKey.add)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else{
            os_log("Unable to decode the name for a Class object.", log: OSLog.default, type: .debug)
            return nil
        }
        let days = aDecoder.decodeObject(forKey: PropertyKey.days) as! String
        let times = aDecoder.decodeObject(forKey: PropertyKey.times) as! String
        let commitment = aDecoder.decodeObject(forKey: PropertyKey.commitment) as! String
        let link = aDecoder.decodeObject(forKey: PropertyKey.link) as! String
        let summary = aDecoder.decodeObject(forKey: PropertyKey.summary) as! String
        let add = aDecoder.decodeBool(forKey: PropertyKey.add)
        self.init(data: [name, days, times, commitment, link, summary], add:add)
    }
    
}

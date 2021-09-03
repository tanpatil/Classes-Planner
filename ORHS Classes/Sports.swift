//
//  Sports.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/10/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import Foundation
import os.log
class Sports: NSObject, NSCoding {

    //MARK: Properties
    var name: String
    var coach: String
    var email: String
    var adds: Bool
    var link: String

    //MARK: Initilizer
    init?(data: [String], adds: Bool) {
        if data.isEmpty {
            print("missing club data")
            return nil
        }
        self.name = data[0]
        self.coach = data[1]
        self.email = data[2]
        self.adds = adds
        self.link = data[3]
        print(self.link)
    }
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let coach = "coach"
        static let email = "email"
        static let adds = "adds"
        static let link = "link"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(coach, forKey: PropertyKey.coach)
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(adds, forKey: PropertyKey.adds)
        aCoder.encode(link, forKey: PropertyKey.link)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else{
            os_log("Unable to decode the name for a Class object.", log: OSLog.default, type: .debug)
            return nil
        }
        let coach = aDecoder.decodeObject(forKey: PropertyKey.coach) as! String
        let email = aDecoder.decodeObject(forKey: PropertyKey.email) as! String
        let adds = aDecoder.decodeBool(forKey: PropertyKey.adds)
        let link = aDecoder.decodeObject(forKey: PropertyKey.link) as! String
        self.init(data: [name, coach, email, link], adds: adds)
    }
    
}

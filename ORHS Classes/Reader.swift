//
//  Reader.swift
//  ORHS Classes
//
//  Created by Steven QU on 5/30/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import Foundation

class Reader {
    
    func readFile(fileURL: URL) -> Array<String>{
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        } catch {
            print("fail")
        }
        let words = readString.components(separatedBy: "\n")
        return words
    }
    
    func findData(fileURL: URL) -> [String]{
        let words = readFile(fileURL: fileURL)
        var output = [String]()
        for lines in words {
            let line = lines.components(separatedBy: "[[[")
            if line.count < 2 {
                break
            }
            let trimmedString = line[1].trimmingCharacters(in: .whitespaces)
            output.append(trimmedString)
        }
        return output
    }
    
    
}

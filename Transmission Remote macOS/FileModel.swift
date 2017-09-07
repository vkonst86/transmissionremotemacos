//
//  FileModel.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 27/07/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class FileModel : NSObject, Mappable {
    var name : String = ""
    var bytesCompleted : Int = 0
    var length : Int = 0
    var isWanted = true
    var priority : Int = 0
    var percentDone : Double
    {
        return Double(bytesCompleted) / Double(length)
    }
    
    var priorityDescription : String
    {
        if !isWanted{
            return FilePriority.skip.rawValue
        }
        
        switch  priority {
        case 1:
            return FilePriority.high.rawValue
        case -1:
            return FilePriority.low.rawValue
        default:
            return FilePriority.normal.rawValue
        }
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        bytesCompleted <- map["bytesCompleted"]
        length <- map["length"]
    }
}

enum FilePriority : String {
    case low = "low"
    case normal = "normal"
    case high = "high"
    case skip = "skip"
}

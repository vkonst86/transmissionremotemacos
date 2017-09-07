//
//  FileStatsModel.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 28/07/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class FileStatsModel : NSObject, Mappable {
    var priority : Int = 0
    var bytesCompleted : Int = 0
    var wanted : Bool = true
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        priority <- map["priority"]
        bytesCompleted <- map["bytesCompleted"]
        wanted <- map["wanted"]
    }
}
